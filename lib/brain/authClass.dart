import 'dart:convert';
import 'dart:io' as Io;
import 'package:pishgamv2/screens/setting_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pishgamv2/screens/homePage.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';
import 'package:pishgamv2/screens/purchaseLessonPage.dart';

abstract class AuthBase {
//  Stream<User> get onAuthStateChange;

  Future<String> signup({@required User user});

  Future<void> signin({@required String username, @required String password});

  Future<bool> signout();

  Future<User> currentUser();

  Future<bool> postEditProfile(EditProfileViewModel model);

  Future<EditProfileViewModel> getEditProfile();

  Future<bool> signOut();

  Future<bool> payWithZarinpall(@required int amount);

  Future<void> initCitiesMap();

  Future<void> initGradesMap();

  Future<HomeViewModel> initializeHome();

  Future<MyLessonsViewModel> initializeMyLesson();

  Future<ShoppingLessonViewModel> initializeShoppingLesson();
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

//switched to singleton

class Auth extends AuthBase {
  Map citiesMap = Map();
  Map gradesMap = Map();
  User _currentUser = new User();

  //singleton pattern in dart
  static final Auth _instance = Auth._internalConst();
  String mainpath = "http://192.168.1.5:8000";

  Auth._internalConst();

  factory Auth() {
    return _instance;
  }

  List<String> get citiesList {
    List<String> citiesList = List<String>();
    citiesMap.forEach((key, value) => citiesList.add(key));
    return citiesList;
  }

  List<String> get gradesList {
    List<String> gradesList = List<String>();
    gradesMap.forEach((key, value) => gradesList.add(key));
    return gradesList;
  }

  static final String _signInChannelName = 'signin';
  static final String _signUpChannelName = 'signup';
  static final String _signoutChannelName = 'signout';
  static final String _zarinpallChannelName = 'zarinpall';
  static final String _citiesChannelName = 'cities';
  static final String _gradesChannelName = 'grades';
  static final String _currentUserChannelName = 'currentuser';
  static final String _homePropertiesName = 'acountlessons';
  static final String _myLessonsChannelName = 'lessons';
  static final String _shoppingChannelName = 'shoppinglist';
  static final String _editProfName = 'editprof';

  static final _signInChannel = MethodChannel(_signInChannelName);
  static final _signUpChannel = MethodChannel(_signUpChannelName);
  static final _signoutChannel = MethodChannel(_signoutChannelName);
  static final _zarinpallChannel = MethodChannel(_zarinpallChannelName);
  static final _citiesChannel = MethodChannel(_citiesChannelName);
  static final _gradesChannel = MethodChannel(_gradesChannelName);
  static final _currentUserChannel = MethodChannel(_currentUserChannelName);
  static final _homePropertiesChannel = MethodChannel(_homePropertiesName);
  static final _myLessonsChannel = MethodChannel(_myLessonsChannelName);
  static final _shoppingLessonChannel = MethodChannel(_shoppingChannelName);
  static final _editProfChannel = MethodChannel(_editProfName);

  @override
  Future<User> currentUser() async {
    final String _methodName = 'currentuser';
    final Map<dynamic, dynamic> result =
        await _currentUserChannel.invokeMethod(_methodName);
    if (result == null)
      return null;
    //todo : pass this user to homeScreen in Authbloc
    else {
      _currentUser = User(
        firstname: result["firstname"],
        lastname: result["lastname"],
        username: result["username"],
        password: result["password"],
        gender: result["gender"],
        phoneNumber: result["phone_number"],
        grade: result["grades"],
        city: result["city"],
      );
      return _currentUser;
    }
  }

  @override
  Future<bool> signOut() async {
    final String _methodName = 'signout';
    bool result = await _signoutChannel.invokeMethod(_methodName);
    return result;
  }

  /*
  * the code here which contain platform channel could throw exception but these
  * exceptions must be handeled in SignInPage and SignUpPage with BlocErrorEvent
  */

  //fixme : on back send user instead of 1/0
  @override
  Future<void> signin({String username, String password}) async {
    final String _methodName = 'signin';
    final Map<dynamic, dynamic> result = await _signInChannel.invokeMethod(
        _methodName, {"username": username, "password": password});
//    if (result != null) {
//      return User(
//        firstname: result["first_name"],
//        lastname: result["last_name"],
//        username: result["user_name"],
//        password: result["password"],
//        gender: result["gender"],
//        phoneNumber: result["phone_number"],
//        grade: result["grades"],
//        avatar: result["avatar"],
//      );
//    }
  }

  @override
  Future<String> signup({User user}) async {
    final String _methodName = 'signup';
    final String result = await _signUpChannel.invokeMethod(_methodName, {
      'firstname': user.firstname,
      'username': user.username,
      'lastname': user.lastname,
      'phonenumber': user.phoneNumber,
      'grades': gradesMap.values.firstWhere(
          (element) => gradesMap[user.grade.trim()] == element,
          orElse: () => null),
      'city': citiesMap.values.firstWhere(
          (element) => citiesMap[user.city.trim()] == element,
          orElse: () => null),
      'gender': user.gender,
    });
    if (result == null)
      throw PlatformException(
          message: "خطا", code: "اشکال در انجام عملیات ثبت نام", details: null);
    else
      return result;
  }

  @override
  Future<bool> payWithZarinpall(int amount) async {
    final String _methodName = "zarinpall";
    // fixme : remove try catch from here --> must handel in bloc
    try {
      final String result =
          await _zarinpallChannel.invokeMethod(_methodName, {'amount': amount});
      if (result == 'done')
        return true;
      else if (result == 'failed') return false;
      return null;
    } catch (_) {
      throw Exception('payment process failed');
    }
  }

  @override
  Future<void> initCitiesMap() async {
    final String _methodName = "cities";
    citiesMap = await _citiesChannel.invokeMethod(_methodName);
  }

  @override
  Future<void> initGradesMap() async {
    final String _methodName = "grades";
    gradesMap = await _gradesChannel.invokeMethod(_methodName);
  }

  //todo : put profile pic in editeProfile method
//  @override
//  Future<void> setUserProfilePicture(String path) async {
//    final bytes = await Io.File(path).readAsBytes();
//    String encodedImage = base64Encode(bytes);
//    String _methodName = "setUserProfile";
//    final String result = await _setUserProfileChannel
//        .invokeMethod(_methodName, {'encodedImage': encodedImage});
//  }

  @override
  Future<EditProfileViewModel> getEditProfile() async {
    final String _getMethodName = "edit_profile_get";
    final String result = await _editProfChannel.invokeMethod(_getMethodName);

    final dynamic data = result != null && result.toString().isNotEmpty
        ? jsonDecode(result)
        : null;

    EditProfileViewModel viewmodel;
    await initGradesMap();
    await initCitiesMap();
    if (data != null) {
      viewmodel = EditProfileViewModel(
        firstname: data['user']['first_name'],
        lastname: data['user']['last_name'],
        username: data['user']['username'],
        grade: data['user']['grade'],
        city: data['user']['cityTitle'],
        isBoy: data['user']['gender'],
        phoneNumber: data['user']['phone_number'],
        avatar: Image.network(mainpath + data['user']['avatar']),
        grades: gradesList,
        cities: citiesList,
      );
    }
    return viewmodel;
  }

  @override
  Future<bool> postEditProfile(EditProfileViewModel model) async {
    final String _postMethodName = "edit_profile_post";

    final bool resutl = await _editProfChannel.invokeMethod(_postMethodName, {
      "firstname": model.firstname,
      "lastname": model.lastname,
      "username": model.username,
      "gender": model.isBoy,
      'grades': gradesMap.values.firstWhere(
          (element) => gradesMap[model.grade.trim()] == element,
          orElse: () => null),
      'city': citiesMap.values.firstWhere(
          (element) => citiesMap[model.city.trim()] == element,
          orElse: () => null),
    });

    return resutl;
  }

  @override
  Future<bool> signout() async {
    final String _methodName = "signout";
    bool result = await _gradesChannel.invokeMethod(_methodName);
    if (result) return true;

    return false;
  }

  @override
  Future<HomeViewModel> initializeHome() async {
    final String _dashboardMethodName = "acountlessons";
    final String _curentUserMethodName = "currentuser";
    final Map<dynamic, dynamic> dResult =
        await _homePropertiesChannel.invokeMethod(_dashboardMethodName);
    final Map<dynamic, dynamic> cResult =
        await _currentUserChannel.invokeMethod(_curentUserMethodName);

//    DateTime now = DateTime.parse(dResult['now']);
    Duration timeLeft;
    String durationString = dResult['timeLeft'].toString().substring(2).trim();
    List<String> parts = durationString.split(':');
    if (dResult["length"] != 0) {
      timeLeft = Duration(
        hours: int.parse(parts[0]),
        minutes: int.parse(parts[1]),
        seconds: int.parse(parts[2].substring(0, 2)),
      );
    }

    Image avatar = Image.network(cResult["avatar"]);

    return HomeViewModel(
      title: dResult["title"],
      teacher: dResult["teacher"],
      name: cResult["firstname"] + " " + cResult["lastname"],
      timeLeft: timeLeft,
      grade: cResult["grades"],
      isActive: dResult["is_active"],
      avatar: avatar,
    );
  }

  @override
  Future<MyLessonsViewModel> initializeMyLesson() async {
    final String _myLessonsMethodName = "lessons";
    final result = await _myLessonsChannel.invokeMethod(_myLessonsMethodName);

    final dynamic data = result != null && result.toString().isNotEmpty
        ? jsonDecode(result)
        : null;
    List<LessonModel> lessonList = List();

    if (data != null)
      for (Map m in data) {
        LessonModel model = LessonModel(
          code: m['code'],
          title: m['title'],
          startDate: DateTime.parse(
              m['start_date'].toString().substring(0, 10) +
                  " " +
                  m['start_date'].toString().substring(11)),
          endDate: DateTime.parse(m['end_date'].toString().substring(0, 10) +
              " " +
              m['end_date'].toString().substring(11)),
          firstClass: DateTime.parse(
              m['first_class'].toString().substring(0, 10) +
                  " " +
                  m['first_class'].toString().substring(11)),
          url: m['url'],
          isActive: m['is_active'],
          description: m['description'],
          image: Image.network(m['image']),
          teacherName: m['teacher'],
          parent_name: m['parent']['title'],
          parent_id: m['parent']['id'].toString(),
        );
        lessonList.add(model);
      }

    lessonList.sort(
        (a, b) => int.parse(a.parent_id).compareTo(int.parse(b.parent_id)));
    return MyLessonsViewModel(lessons: lessonList);
  }

  @override
  Future<ShoppingLessonViewModel> initializeShoppingLesson() async {
    final String _shoppingLessonMethodName = "shoppinglist";
    String result =
        await _shoppingLessonChannel.invokeMethod(_shoppingLessonMethodName);

    final data = jsonDecode(result);
    List<LessonModel> lessonList = List();

    for (Map m in data) {
      LessonModel model = LessonModel(
        title: m['title'],
        startDate: DateTime.parse(m['start_date'].toString().substring(0, 10) +
            " " +
            m['start_date'].toString().substring(11)),
        endDate: DateTime.parse(m['end_date'].toString().substring(0, 10) +
            " " +
            m['end_date'].toString().substring(11)),
        code: m['code'],
        amount: m['amount'],
        description: m['description'],
        image: Image.network(m['image']),
        teacherName: m['teacher'],
        parent_name: m['parent']['title'],
        parent_id: m['parent']['id'].toString(),
        courseCalendar: <DateTime>[
          m['course_calendars'][0] != null
              ? DateTime.parse(
                  m['course_calendars'][0].toString().substring(0, 10) +
                      " " +
                      m['course_calendars'][0].toString().substring(11))
              : null,
          m['course_calendars'][1] != null
              ? DateTime.parse(
                  m['course_calendars'][1].toString().substring(0, 10) +
                      " " +
                      m['course_calendars'][1].toString().substring(11))
              : null,
          m['course_calendars'][2] != null
              ? DateTime.parse(
                  m['course_calendars'][2].toString().substring(0, 10) +
                      " " +
                      m['course_calendars'][2].toString().substring(11))
              : null,
        ],
      );
      lessonList.add(model);
    }
    lessonList.sort(
        (a, b) => int.parse(a.parent_id).compareTo(int.parse(b.parent_id)));
    return ShoppingLessonViewModel(lessons: lessonList);
  }
}

class User extends Equatable {
  //fixme: address!!
  User(
      {this.username,
      this.firstname,
      this.lastname,
      this.city,
      this.gender,
      this.grade,
      this.password,
      this.avatar,
      this.phoneNumber,
      this.socialnumber});

  final String username;
  final String firstname;
  final String lastname;
  final String avatar;
  final String password;
  final String socialnumber;
  final String city;
  final String gender;
  final String grade;
  final String phoneNumber;

  @override
  String toString() {
    // TODO: implement toString
    return firstname.toString() +
        "\n" +
        lastname.toString() +
        "\nusername: " +
        username.toString() +
        "\ngender: " +
        gender.toString() +
        "\ncity: " +
        city.toString() +
        "\ngrade: " +
        grade.toString() +
        "\nphoneNumber: " +
        phoneNumber.toString() +
        "\nsocialNumber: " +
        socialnumber.toString() +
        "\npassword: " +
        password.toString();
  }

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
