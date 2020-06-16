import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'authClass.dart';



abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckIfSignedInBefor extends AuthEvent {
  @override
  List<Object> get props => [];
}

class DoSignIn extends AuthEvent {
  const DoSignIn({@required this.username, @required this.password});
  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class GoAuthenticationPage extends AuthEvent {
  @override
  List<Object> get props => null;
}

class DoSignUp extends AuthEvent {
  const DoSignUp({@required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class CatchError extends AuthEvent {
  CatchError({this.message, this.detail});
  final String message;
  final String detail;

  @override
  List<Object> get props => null;
}


abstract class AuthState extends Equatable {
  const AuthState();
}

class SignUpIsLoadingSta extends AuthState {
  @override
  List<Object> get props => null;
}

class SignInIsLoadingSta extends AuthState {
  @override
  List<Object> get props => null;
}

class InitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class StartAnimation extends AuthState {
  @override
  List<Object> get props => null;
}

class Home extends AuthState {
  @override
  List<Object> get props => [];
}

class SignIn extends AuthState {
  @override
  List<Object> get props => [];
}

class SignUpLoadingFinished extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SignInLoadingFinished extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AuthenticationError extends AuthState {
  AuthenticationError({this.message, this.details});
  final String message;
  final String details;

  @override
  List<Object> get props => [Random().nextInt(1000)];
}

// todo : platform Exception


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.auth);

  final AuthBase auth;

  @override
  get initialState => InitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if(event is CheckIfSignedInBefor) {
      User user;
      try {
        user = await auth.currentUser();
        print('herl');
        await auth.initCitiesMap();
        print('herl2');
        await auth.initGradesMap();
        print('herl3');
      } on PlatformException catch (err) {
        this.add(CatchError(
          message: err.message,
          detail: err.code,
        ));
      } catch (err) {
        print('error happend in flutter code!');
      }
      print('sdfsdal');
      yield user == null ? StartAnimation() : Home();
    }
    else if(event is DoSignIn) {
      yield SignInIsLoadingSta();
      User user;
      try {
        user = await auth.signin(username: event.username, password: event.password);
        await Future.delayed(Duration(seconds: 2));
      } on PlatformException catch (err) {
        this.add(CatchError(
          message: err.message,
          detail: err.code,
        ));
      } catch (err) {
        print('error happend in flutter code!');
      }
      yield SignInLoadingFinished();
      yield user == null ? AuthenticationError(message : "ناموفق", details: "اشکال در ارتباط با سرور یا رمز و کلمه عبور نامعتبر می باشد.") : Home();
      if(user != null)
        await this.close();
    }
    else if (event is DoSignUp) {
      yield SignUpIsLoadingSta();
      String result;
      try {
        result = await auth.signup(user: event.user);
      } on PlatformException catch (err) {
        this.add(CatchError(
          message: err.message,
          detail: err.code,
        ));
      } catch (err) {
        print('error happend in flutter code!');
      }
      yield SignUpLoadingFinished();
      print(result);
      yield result == null ? AuthenticationError(message : "ناموفق", details: "عملیات ثبت نام با اشکال مواجه شده لطفا بعدا دوباره تلاش کنید.") : SignIn();
    }
    else if (event is GoAuthenticationPage) {
      yield SignIn();
    }
    else if (event is CatchError) {
      yield AuthenticationError(
        message: event.message,
        details: event.detail,
      );
    }
  }
}
