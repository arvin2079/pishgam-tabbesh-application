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
}

class Auth extends AuthBase {
  static final String _signInChannelName = 'signin';
  static final String _signUpChannelName = 'signup';
  static final String _zarinpallChannelName = 'zarinpall';

  static final _signInChannel = MethodChannel(_signInChannelName);
  static final _signUpChannel = MethodChannel(_signUpChannelName);
  static final _zarinpallChannel = MethodChannel(_zarinpallChannelName);

//  @override
//  // TODO: implement onAuthStateChange
//  Stream<User> get onAuthStateChange => null;

  @override
  Future<User> currentUser() {
    // TODO: implement currentUser
    return null;
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
      final Map result = await _signInChannel.invokeMethod(
          _methodName, {"username": username, "password": password});
      // todo : check if errors are handeled with bloc or not!
      if (result != null) {
        return User(
          // fixme : city , socialNumber? password!
          firstname: result[0],
          lastname: result[1],
          username: result[2],
          password: result[3],
          gender: result[4],
          phoneNumber: result[5],
          grade: result[6],
        );
      } else
        return null;
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
        'socialnumber' : user.socialnumber,
        'phonenumber' : user.phoneNumber,
        'grade' : user.grade,
        'city' : user.city,
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
    final String result = await _zarinpallChannel.invokeMethod(_methodName, {'amount' : amount});
    if(result == 'done')
      return true;
    else if(result == 'failed')
      return false;
    throw Exception('payment process failed');
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
