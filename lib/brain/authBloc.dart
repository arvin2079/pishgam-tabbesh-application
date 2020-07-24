import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'authClass.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class Signout extends AuthEvent{
  @override
  List<Object> get props => null;
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
  AuthenticationError({this.message, this.details, this.onPressed});

  final String message;
  final String details;
  final Function onPressed;

  @override
  List<Object> get props => [Random().nextInt(1000)];
}

// todo : platform Exception

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Auth auth = Auth();

  @override
  get initialState => InitialState();

  Future<bool> checkInternetConnection() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity(); // User defined class
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is CheckIfSignedInBefor) {
      if (await checkInternetConnection()) {
        User user;
        try {
          user = await auth.currentUser();
          print(user.toString());
          await auth.initCitiesMap();
          await auth.initGradesMap();
        } on PlatformException catch (err) {
          this.add(CatchError(
            message: err.message,
            detail: err.code,
          ));
        } catch (err) {
          print('error --> ' + err.toString());
//          print('error happend in flutter code!');
        }
        yield user == null ? StartAnimation() : Home();
      } else {
        yield AuthenticationError(
            message: "اشکال در اتصال به اینترنت",
            details:
                "لطفا از اتصال خود به اینترنت اطمینان حاصل کرده و دوباره تلاش کنید.",
            onPressed: () async {
              await Future.delayed(Duration(milliseconds: 500));
              this.add(CheckIfSignedInBefor());
            });
      }
    }

    else if (event is DoSignIn) {
      yield SignInIsLoadingSta();
      try {
        await auth.signin(username: event.username, password: event.password);
      } on PlatformException catch (err) {
        this.add(CatchError(
          message: err.message,
          detail: err.code,
        ));
      } catch (err) {
        print(err.toString());
      }
      yield SignInLoadingFinished();
      yield Home();
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
        print(err.toString());
      }
      yield SignUpLoadingFinished();
      if (result != null) {
        this.add(CatchError(
          message: 'موفق',
          detail: 'ثبت نام شما با موفقیت به پایان رسید . رمز عبور به شماره همراه شما ارسال خواهد شد',
        ));
        yield SignIn();
      }
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

    else if(event is Signout) {
      auth.signOut();
      yield SignIn();
    }
  }
}
