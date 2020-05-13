abstract class AuthBase {
  Stream<User> get onAuthStateChange;
  Future<User> signup();
  Future<User> signin();
  Future<User> currentUser();
  Future<void> signOut();
  // todo : zarinpal (buying lessons)
}

// TODO : userToken smust define in singleton design pattern

class Auth extends AuthBase{

  @override
  Future<User> signin() {
    // TODO: implement signip
    return null;
  }

  @override
  Future<User> signup() {
    // TODO: implement signup
    return null;
  }

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
}


class User {}