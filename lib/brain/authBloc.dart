import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'authClass.dart';



abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckIfSignedInBefor extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DoSignIn extends AuthEvent {
  const DoSignIn({@required this.username, @required this.password});
  final String username;
  final String password;

  @override
  // TODO: implement props
  List<Object> get props => [username, password];
}

class GoAuthenticationPage extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class DoSignUp extends AuthEvent {
  const DoSignUp({@required this.user});

  final User user;

  @override
  // TODO: implement props
  List<Object> get props => [user];
}



abstract class AuthState extends Equatable {
  const AuthState();
}

class InitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StartAnimation extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Home extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SignIn extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticationError extends AuthState {
  AuthenticationError(this.message);
  final String message;

  @override
  // TODO: implement props
  List<Object> get props => [message];
}



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.auth);

  final AuthBase auth;

  @override
  get initialState => InitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if(event is CheckIfSignedInBefor) {
      User user = await auth.currentUser();
      yield user == null ? StartAnimation() : Home();
    } else if(event is DoSignIn) {
      User user = await auth.signin(username: event.username, password: event.password);
      yield user == null ? AuthenticationError("signin_error") : Home();
    } else if (event is DoSignUp) {
      User user = await auth.signup(user: event.user);
      yield user == null ? AuthenticationError("signup_error") : SignIn();
    } else if (event is GoAuthenticationPage) {
      yield SignIn();
    }
  }
}
