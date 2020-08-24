import 'dart:convert';
import 'package:pishgamv2/components/shoppingCard.dart';
import 'package:pishgamv2/screens/Mylessons_files_screen.dart';
import 'package:pishgamv2/screens/setting_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pishgamv2/screens/homePage.dart';
import 'package:pishgamv2/screens/myLessonsPage.dart';
import 'package:pishgamv2/screens/shoppingLessonPage.dart';

abstract class AuthBase {
//  Stream<User> get onAuthStateChange;

  Future<String> signup({@required User user});

  Future<void> signin({@required String username, @required String password});

  Future<bool> signout();

  Future<User> currentUser();

  Future<bool> postEditProfile(EditProfileViewModel model);

  Future<EditProfileViewModel> getEditProfile();

  Future<bool> signOut();

  Future<String> payWithZarinpall(List<BasketItem> items);

  Future<void> initCitiesMap();

  Future<void> initGradesMap();

  Future<void> initSearchFilters();

  Future<HomeViewModel> initializeHome();

  Future<MyLessonsViewModel> initializeMyLesson();

  Future<ShoppingLessonViewModel> initializeShoppingLesson(
      {String grade, String teacher, String parentLesson});

  Future<MyLessonFilesViewModel> initializeMyLessonFiles(String courseId);

  Future<bool> changePass({@required String oldPass, @required String newPass});

  Future<void> uploadProfilePic(String base64, String filename);
}

//switched to singleton

class Auth extends AuthBase {
  Map citiesMap = Map();
  Map gradesMap = Map();
  Map teachersMap = Map();
  Map parentLessonsMap = Map();
  User _currentUser = new User();

  //singleton pattern  in dart
  static final Auth _instance = Auth._internalConst();
  String mainpath = "http://192.168.1.3:8000";

//  String mainpath="http://192.168.43.139:8000";
//  String mainpath="http://192.168.43.159:8000";

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

  List<String> get teahcersList {
    List<String> gradesList = List<String>();
    teachersMap.forEach((key, value) => gradesList.add(key));
    return gradesList;
  }

  List<String> get parentLessonsList {
    List<String> gradesList = List<String>();
    parentLessonsMap.forEach((key, value) => gradesList.add(key));
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
  static final String _changePassName = 'changepass';
  static final String _lessonFilesName = 'lessonFiles';
  static final String _changeAvatarName = 'changeAvatar';
  static final String _searchFilterName = 'searchFilter';

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
  static final _changePassChannel = MethodChannel(_changePassName);
  static final _lessonFilesChannel = MethodChannel(_lessonFilesName);
  static final _changeAvatarChannel = MethodChannel(_changeAvatarName);
  static final _searchFilterChannel = MethodChannel(_searchFilterName);

  @override
  Future<User> currentUser() async {
    final String _methodName = 'currentuser';
    print('23');
    final String result = await _currentUserChannel.invokeMethod(_methodName);
    print('24');

    if (result == null) return null;

    final dynamic data = result != null && result.toString().isNotEmpty
        ? jsonDecode(result)
        : null;

    print("current user: ");
    print(result);


    _currentUser = User(
      firstname: data["first_name"],
      lastname: data["last_name"],
      username: data["username"],
      gender: data["gender"].toString(),
      phoneNumber: data["phone_number"],
      grade: data["grade"],
      city: data["cityTitle"],
      avatar: mainpath + data["avatar"],
    );

    return _currentUser;
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
  Future<String> payWithZarinpall(List<BasketItem> items) async {
    final String _methodName = "zarinpall";
    const String callbackLink = "tabeshunilink://payedwithzarinpal/pay";

    int totalPrice = 0;
    List<int> itemIds = List();

    items.forEach((element) {
      totalPrice += element.price.toInt();
      itemIds.add(element.lessonId);
    });

    final String result = await _zarinpallChannel.invokeMethod(_methodName, {
      'total_pr': totalPrice.toString(),
      'total_id': itemIds.join(' '),
      'url': callbackLink,
    });

    final dynamic data = result != null && result.toString().isNotEmpty
        ? jsonDecode(result)
        : null;

    return data["url"];
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
        grade: data['user']['grade'] != null &&
                data['user']['grade'].toString().isNotEmpty
            ? data['user']['grade']
            : null,
        city: data['user']['cityTitle'] != null &&
                data['user']['cityTitle'].toString().isNotEmpty
            ? data['user']['cityTitle']
            : null,
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
    print('12');
    final Map<dynamic, dynamic> dResult =
        await _homePropertiesChannel.invokeMethod(_dashboardMethodName);
    print('13');
    final String cResult =
        await _currentUserChannel.invokeMethod(_curentUserMethodName);
    print('14');
    final dynamic data = cResult != null && cResult.toString().isNotEmpty
        ? jsonDecode(cResult)
        : null;

//    DateTime now = DateTime.parse(dResult['now']);
    Duration timeLeft;
    String durationString;
    bool remainOneDay = dResult['timeLeft'].toString().substring(0, 2) == "1 ";
    if (dResult['timeLeft'].toString().substring(0, 2) == "1 " ||
        dResult['timeLeft'].toString().substring(0, 2) == "-1")
      durationString = dResult['timeLeft'].toString().substring(2).trim();
    else
      durationString = dResult['timeLeft'].toString();

    print(durationString);
    List<String> parts = durationString.split(':');
    if (dResult["length"] != 0) {
      timeLeft = Duration(
        days: remainOneDay ? 1 : 0,
        hours: int.parse(parts[0]),
        minutes: int.parse(parts[1]),
        seconds: int.parse(parts[2].substring(0, 2)),
      );
    }

    Image avatar = Image.network(mainpath + data["avatar"]);

    return HomeViewModel(
      title: dResult["title"],
      teacher: dResult["teacher"],
      name: data["first_name"] + " " + data["last_name"],
      timeLeft: timeLeft,
      url: dResult["url"] == "null" ? null : dResult["url"],
      grade: data["grade"],
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
          firstClass: m['first_class'] != null
              ? DateTime.parse(m['first_class'].toString().substring(0, 10) +
                  " " +
                  m['first_class'].toString().substring(11))
              : null,
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
  Future<ShoppingLessonViewModel> initializeShoppingLesson(
      {String grade, String teacher, String parentLesson}) async {
    final String _shoppingLessonMethodName = "shoppinglist";

    print(gradesMap.values.firstWhere(
        (element) => grade != null && gradesMap[grade.trim()] == element,
        orElse: () => null));
    print(teachersMap.values.firstWhere(
        (element) => teacher != null && teachersMap[teacher.trim()] == element,
        orElse: () => null));
    print(parentLessonsMap.values.firstWhere(
        (element) =>
            parentLesson != null &&
            parentLessonsMap[parentLesson.trim()] == element,
        orElse: () => null));
    print('finish');

    String result =
        await _shoppingLessonChannel.invokeMethod(_shoppingLessonMethodName, {
      "grade": gradesMap.values.firstWhere(
          (element) => grade != null && gradesMap[grade.trim()] == element,
          orElse: () => null),
      "teacher": teachersMap.values.firstWhere(
          (element) =>
              teacher != null && teachersMap[teacher.trim()] == element,
          orElse: () => null),
      "parentLesson": parentLessonsMap.values.firstWhere(
          (element) =>
              parentLesson != null &&
              parentLessonsMap[parentLesson.trim()] == element,
          orElse: () => null),
    });

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
        id: m['id'],
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

  @override
  Future<bool> changePass({oldPass, newPass}) async {
    final String _changePassMethodName = "changepass";
    final bool result =
        await _changePassChannel.invokeMethod(_changePassMethodName, {
      "old_password": oldPass.trim(),
      "new_passwrod": newPass.trim(),
    });

    return result;
  }

  @override
  Future<MyLessonFilesViewModel> initializeMyLessonFiles(
      String courseId) async {
    final String _lessonFilesMethodName = "lessonFiles";
    String result =
        await _lessonFilesChannel.invokeMethod(_lessonFilesMethodName, {
      "course_id": courseId,
    });

    List<DocumentModel> docs = List();
    final data = jsonDecode(result);

    for (Map m in data["documents"]) {
      DocumentModel model = DocumentModel(
        title:
            m["title"] + "." + m["upload_document"].toString().split('.').last,
        sender: m["sender"],
        description: m["description"],
        url: mainpath + m["upload_document"],
      );
      docs.add(model);
    }

    return MyLessonFilesViewModel(
      courseTitle: data["course"]["title"],
      teacher: data["course"]["teacher"],
      docs: docs,
    );
  }

  @override
  Future<void> uploadProfilePic(String base64, String filename) async {
    final String _lessonFilesMethodName = "changeAvatar";
    await _changeAvatarChannel.invokeMethod(_lessonFilesMethodName, {
      "file_name": filename,
      "file": base64,
    });
  }

  @override
  Future<void> initSearchFilters() async {
    final String _searchFilterMethodName = "getSearchFilter";
    final String result =
        await _searchFilterChannel.invokeMethod(_searchFilterMethodName);

    if (result == null || result.isEmpty) return;
    print(result);
    final data = jsonDecode(result);

    gradesMap.clear();
    for (Map m in data['grades']) {
      print(m['id']);
      print(int.parse(m['id'].toString().trim()).toString());
      gradesMap[m['title']] = int.parse(m['id'].toString().trim());
    }

    teachersMap.clear();
    for (Map m in data['teachers']) {
      teachersMap[m['full_name']] = int.parse(m['id'].toString().trim());
    }

    parentLessonsMap.clear();
    for (Map m in data['lessons']) {
      parentLessonsMap[m['title']] = int.parse(m['id'].toString().trim());
    }
    print('shopping dropdown items maps');
    print(parentLessonsMap.toString());
    print(gradesMap.toString());
    print(teachersMap.toString());
  }
}

class User extends Equatable {
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
