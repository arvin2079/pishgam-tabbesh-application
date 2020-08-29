abstract class StringValidator {
  bool isValid(String value);
}

// no more need to validate email address

// class ValidEmailString implements StringValidator {
//   @override
//   bool isValid(String value) {
//     if (value.isEmpty) return false;
//     RegExp emailReg = RegExp(r'(?:\S)+@(?:\S)+\.(?:\S)+', caseSensitive: false);
//     return emailReg.hasMatch(value);
//   }
// }

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class CredentioalStringValidator {
  final StringValidator emailValidator = NonEmptyStringValidator();
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

class PersianValidator with LanguageDetector implements StringValidator {
  @override
  bool isValid(String value) {
    if (value.isEmpty || hasEnglishChar(value)) return false;
    return true;
  }
}

class EnglishValidator with LanguageDetector implements StringValidator {
  @override
  bool isValid(String value) {
    if (value.isEmpty || !hasEnglishChar(value)) return false;
    return true;
  }
}

class LanguageDetector {
  bool hasEnglishChar(String string) {
    RegExp reg = RegExp(r'\w');
    return reg.hasMatch(string);
  }

  bool isEnglish(String string) {
    RegExp reg = RegExp(r'\w');

    for (int i = 0; i < string.length; i++) {
      if (!reg.hasMatch(string.substring(i, i + 1))) return false;
    }
    return true;
  }
}



class SignupFieldValidator {
  final StringValidator firstnameValidator = PersianValidator();
  final StringValidator lastnameValidator = PersianValidator();
  final StringValidator usernameValidator = EnglishValidator();
  final StringValidator phoneNumberValidator = PhoneNumberStringValidator();
  final String inValidFirstnameErrorMassage = 'نام کوچک صحیح خود را وارد کنید به صورت فارسی';
  final String inValidLastnameErrorMassage = 'نام خوانوادگی صحیح خود را وارد کنید به صورت فارسی';
  final String inValidUsernameErrorMassage = 'نام کاربری صحیح خود را وارد کنید به صورت انگلیسی';
  final String inValidPhoneNumberErrorMassage = 'شماره همراه صحیح خود را وارد کنید';
}

class EditProfileValidator {
  final StringValidator firstnameValidator = PersianValidator();
  final StringValidator lastnameValidator = PersianValidator();
  final StringValidator usernameValidator = EnglishValidator();
  final StringValidator phoneNumberValidator = PhoneNumberStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String notValidPasswordError = 'رمز عبور غیر مجاز';
  final String inValidFirstnameErrorMassage = 'نام کوچک صحیح خود را وارد کنید به صورت فارسی';
  final String inValidLastnameErrorMassage = 'نام خوانوادگی صحیح خود را وارد کنید به صورت فارسی';
  final String inValidUsernameErrorMassage = 'نام کاربری صحیح خود را وارد کنید به صورت انگلیسی';
  final String inValidPhoneNumberErrorMassage = 'شماره همراه صحیح خود را وارد کنید';
}

