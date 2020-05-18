import 'package:bloc/bloc.dart';
import 'authClass.dart';

enum ApplicationAuthEvent {
  landing,
  signUp,
  signIn,
  signOut,
}

//can be (UserDoesntExist) or ...
enum ApplicationAuthState {
  landing,
  signedIn,
  signedOut,
  signedUp,
}

class AuthEvent {
  AuthEvent({this.user, this.event});

  final User user;
  final ApplicationAuthEvent event;
}

class AuthState {
  AuthState({this.user, this.state});

  final User user;
  final ApplicationAuthState state;
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.auth);

  final AuthBase auth;

  @override
  get initialState =>
      AuthState(user: null, state: ApplicationAuthState.landing);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event.event) {
      case ApplicationAuthEvent.landing:
        {
          User user = await auth.currentUser();
          yield AuthState(
            user: user,
            state: user == null
                ? ApplicationAuthState.signedOut
                : ApplicationAuthState.signedIn,
          );
        }
        break;
      case ApplicationAuthEvent.signIn:
        // TODO: Handle this case.
        break;
      case ApplicationAuthEvent.signOut:
        // TODO: Handle this case.
        break;
      case ApplicationAuthEvent.signUp:
        // TODO: Handle this case.
        break;
    }
  }
}
