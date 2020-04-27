import 'package:flutter/services.dart';

abstract class AuthBase {
  static const platform = const MethodChannel('authChannel');
  Stream<User> get onAuthStateChange;
  Future<User> signup();
  Future<User> signin();
  Future<User> currentUser();
  Future<void> signOut();
  Future<bool> validatePhoneNumber(String phoneNumber);
}

// TODO : userToken must define in singleton design pattern

class Auth extends AuthBase{

  @override
  Future<User> signin() {
    // TODO: implement signip
    return null;
  }

  @override
  Future<User> signup() async{
    // TODO: implement signup
    return null;
  }

  @override
  // TODO: implement onAuthStateChange
  Stream<User> get onAuthStateChange => null;

  @override
  Future<User> currentUser() async{
    // TODO: implement currentUser
    return null;
  }

  @override
  Future<void> signOut() async{
    // TODO: implement signOut
    return null;
  }

  @override
  Future<bool> validatePhoneNumber(String phoneNumber) async{
    try {
      String result = await AuthBase.platform.invokeMethod('PHONE_NUMBER_VALIDATION', {'phone_number': phoneNumber});
      switch(result) {
        case 'true' :
          return true;
          break;
        case 'false' :
          return false;
          break;
        case 'null' :
          return null;
          break;
      }
    } catch (e){
      print(e.toString());
      return null;
    }
  }
}


class User {}