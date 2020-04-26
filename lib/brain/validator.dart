abstract class StringValidator {
  bool isValid(String value);
}

class ValidEmailString implements StringValidator {
  @override
  bool isValid(String value) {
    if (value.isEmpty) return false;
    RegExp emailReg = RegExp(r'(?:\S)+@(?:\S)+\.(?:\S)+', caseSensitive: false);
    return emailReg.hasMatch(value);
  }
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class CredentioalStringValidator {
  final StringValidator emailValidator = ValidEmailString();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String notValidEmailError = 'ایمیل غیر مجاز';
  final String notValidPasswordError = 'رمز عبور غیر مجاز';
}

class PhoneNumberStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    RegExp regExp = RegExp(r'9\d{9}');
    return regExp.hasMatch(value) && value.length == 10;
  }
}
