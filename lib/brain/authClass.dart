import 'dart:convert';
import 'dart:io' as Io;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AuthBase {
//  Stream<User> get onAuthStateChange;

  Future<bool> signup({@required User user});

  Future<User> signin({@required String username, @required String password});

  Future<User> currentUser();

  Future<void> signOut();

  Future<Image> getUserProfilePicture();

  Future<bool> payWithZarinpall(@required int amount);

  Future<void> initCitiesMap();

  Future<void> initGradesMap();

  Future<void> setUserProfilePicture(String path);
}

// fixme : handeling open bloc stream warning (e.g. ref signup_page.dart , splashScreen).
// fixme : phone number validation (10 digit).
// fixme : remove useless class from testable demo version.
// fixme : if my lessons was empty , my lessons card should not be shown.
// fixme : handeling sign in in progress and sign up in progress with authbloc.

// fixme : sending code of city or grade to the server not String.
// fixme : remove address and socialnumber.
// fixme : sending profile pic in sign up.
// fixme : name and user properties for home page and other parts of app.
// fixme : adding lesson that is purchased to user lessons.
// todo : getting list of grades and city from server.
// todo : change profile pic in setting.
// todo : getting error messages from server and use theme in ui state management when error occured.
// todo : method channel for download lesson files.
// todo : method channel for remaining time to class.
// todo : method channel for myLessons.
// todo : method channel for lessons to purchase.
// todo(optional or in future versoins) : messages for internet low speed or disconnection.
// todo(optional or in future versoins) : refresh option for my lessons and purchase lessons pages.
// todo(optional or in future versoins) : theme (dark and light)
// todo(optional or in future versoins) : language.
// todo(optional or in future versoins) : Azmoon online.

class Auth extends AuthBase {

  Map citiesMap= Map();
  Map gradesMap= Map();
  User _currentUser = new User();


  List<String> get citiesList{
    List<String> citiesList =List<String>();
    citiesMap.forEach((key, value) => citiesList.add(value));
    return citiesList;
  }

  List<String> get gradesList{
    List<String> gradesList = List<String>();
    gradesMap.forEach((key, value) => gradesList.add(value));
    return gradesList;
  }

  static final String _signInChannelName = 'signin';
  static final String _signUpChannelName = 'signup';
  static final String _zarinpallChannelName = 'zarinpall';
  static final String _citiesChannelName = 'cities';
  static final String _gradesChannelName = 'grades';
  static final String _currentUserChannelName = 'currentUser';
  static final String _setUserProfileChannelName = 'setUserprofile';


  static final _signInChannel = MethodChannel(_signInChannelName);
  static final _signUpChannel = MethodChannel(_signUpChannelName);
  static final _zarinpallChannel = MethodChannel(_zarinpallChannelName);
  static final _citiesChannel = MethodChannel(_citiesChannelName);
  static final _gradesChannel = MethodChannel(_gradesChannelName);
  static final _currentUserChannel= MethodChannel(_currentUserChannelName);
  static final _setUserProfileChannel = MethodChannel(_setUserProfileChannelName);


  @override
  Future<User> currentUser() async {
    final String _methodName= 'currentUser';
    final Map<String ,String> result = await _currentUserChannel.invokeMethod(_methodName);
    if (result.isEmpty)
      return null;
    else{
      _currentUser = User(
        firstname: result["first_name"],
        lastname: result["last_name"],
        username: result["user_name"],
        password: result["password"],
        gender: result["gender"],
        phoneNumber: result["phone_number"],
        grade: result["grades"],
      );
      return _currentUser;
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    return null;
  }

  @override
  Future<Image> getUserProfilePicture() {
    // TODO: get image from user if it return null means no picture uploaded
    return null;
  }

  /*
  * the code here which contain platform channel could throw exception but these
  * exceptions must be handeled in SignInPage and SignUpPage with BlocErrorEvent
  */

  @override
  Future<User> signin({String username, String password}) async {
    final String _methodName = 'signin';
    try {
      final Map<String, String> result = await _signInChannel.invokeMethod(
          _methodName, {"username": username, "password": password});
      if (result != null) {
        return User(
          firstname: result["first_name"],
          lastname: result["last_name"],
          username: result["user_name"],
          password: result["password"],
          gender: result["gender"],
          phoneNumber: result["phone_number"],
          grade: result["grades"],
        );
      }
    } catch(_) {
      return null;
    }
  }

  @override
  Future<bool> signup({User user}) async{
    final String _methodName = 'signup';
    try {
      final String result = await _signUpChannel.invokeMethod(_methodName, {
        'firstname' : user.firstname,
        'lastname' : user.lastname,
        'phonenumber' : user.phoneNumber,
        'grade' : gradesList.indexOf(user.grade),
        'city' : citiesMap.keys.firstWhere((element) => citiesMap[element]==user.city , orElse: () => null),
        'gender' : user.gender,
        //fixme: address!!
      });
      if(result == 'added')
        return true;
      else if (result == 'failed')
        return false;
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> payWithZarinpall(int amount) async{
    final String _methodName = "zarinpall";
    try{
      final String result = await _zarinpallChannel.invokeMethod(_methodName, {'amount' : amount});
      if(result == 'done')
        return true;
      else if(result == 'failed')
        return false;
      return null;
    } catch(_){
      throw Exception('payment process failed');
    }
  }

  @override
  Future<void> initCitiesMap() async {
    final String _methodName= "cities";
    citiesMap= await _citiesChannel.invokeMethod(_methodName);
  }

  @override
  Future<void> initGradesMap() async{
    final String _methodName= "grades";
    gradesMap= await _gradesChannel.invokeMethod(_methodName);
  }

  @override
  Future<void> setUserProfilePicture(String path) async {
    final bytes = await Io.File(path).readAsBytes();
    String encodedImage = base64Encode(bytes);
    String _methodName = "setUserProfile";
    final String result = await _setUserProfileChannel.invokeMethod(_methodName , {'encodedImage' : encodedImage});
  }
}

class User extends Equatable {
  //fixme: address!!
  User({this.username,
    this.firstname,
    this.lastname,
    this.city,
    this.gender,
    this.grade,
    this.password,
    this.phoneNumber,
    this.socialnumber});

  final String username;
  final String firstname;
  final String lastname;
  final String password;
  final String socialnumber;
  final String city;
  final String gender;
  final String grade;
  final String phoneNumber;

  @override
  // TODO: implement props
  List<Object> get props => [
    username,
    firstname,
    lastname,
    socialnumber,
    city,
    gender,
    password,
    grade,
    phoneNumber
  ];
}

// fixme : user profile picture
