import 'package:bloc/bloc.dart';
import 'authClass.dart';



enum ApplicationAuthEvent {
  initialize,
  signIn,
  signOut,
  phoneNumberValidation,
}

class BlocEvent {
  BlocEvent(this.applicationEvent, {this.arguments});
  final Map<String, String> arguments;
  final ApplicationAuthEvent applicationEvent;
}


enum ApplicationAuthState {
  landing,
  signedIn,
  SignedOut,
}

class BlocState {
  BlocState(this.user, this.applicationState);
  final User user;
  final ApplicationAuthState applicationState;
}




class AuthBloc extends Bloc<BlocEvent, BlocState> {
  final AuthBase auth = Auth();

  @override
  get initialState => BlocState(null, ApplicationAuthState.landing);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.applicationEvent) {
      case ApplicationAuthEvent.initialize:
        {
          User user = await auth.currentUser();
          if (user == null) await Future.delayed(Duration(seconds: 5));

          // FIXME : send user arguments if its needed with the state

          yield BlocState(
            user,
            user == null
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
      case ApplicationAuthEvent.phoneNumberValidation:
        // TODO: Handle this case.
        break;
    }
  }
}
