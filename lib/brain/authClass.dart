import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthBase {
  Stream<User> get onAuthStateChange;

  Future<User> signup({@required User user});

  Future<User> signin({@required String username, @required String password});

  Future<User> currentUser();

  Future<void> signOut();

  Future<Image> getUserProfilePicture();
// todo : zarinpal (buying lessons)
}

// TODO : userToken smust define in singleton design pattern

class Auth extends AuthBase {
  @override
  // TODO: implement onAuthStateChange
  Stream<User> get onAuthStateChange => null;

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

  @override
  Future<User> signin({String username, String password}) {
    // TODO: implement signin
    return null;
  }

  @override
  Future<User> signup({User user}) {
    // TODO: implement signup
    return null;
  }
}

class User extends Equatable {
  User(
      {this.uid,
      this.username,
      this.firstname,
      this.lastname,
      this.city,
      this.gender,
      this.grades,
      this.phoneNumber,
      this.nationalCode});

  final String uid;
  final String username;
  final String firstname;
  final String lastname;
  final String nationalCode;
  final String city;
  final String gender;
  final String grades;
  final String phoneNumber;

  @override
  // TODO: implement props
  List<Object> get props => [
        uid,
        username,
        firstname,
        lastname,
        nationalCode,
        city,
        gender,
        grades,
        phoneNumber
      ];
}
