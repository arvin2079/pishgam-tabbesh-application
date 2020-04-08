import 'package:bloc/bloc.dart';
import 'authClass.dart';

enum ApplicationAuthEvent {
  landing,
  signIn,
  signOut,
}

//can be (UserDoesntExist) or ...
enum ApplicationAuthState {
  landing,
  signedIn,
  SignedOut,
}

class AuthState {
  AuthState({this.user, this.state});

  final User user;
  final ApplicationAuthState state;
}

class AuthBloc extends Bloc<ApplicationAuthEvent, AuthState> {
  final AuthBase auth = Auth();

  @override
  get initialState =>
      AuthState(user: null, state: ApplicationAuthState.landing);

  @override
  Stream<AuthState> mapEventToState(ApplicationAuthEvent event) async* {
    switch (event) {
      case ApplicationAuthEvent.landing: {
        //todo : omit delay later
        await Future.delayed(Duration(seconds: 6));
          User user = await auth.currentUser();
          yield AuthState(
            user: user,
            state: user == null
                ? ApplicationAuthState.SignedOut
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
    }
  }
}
