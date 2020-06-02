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
    RegExp regExp = RegExp(r'09\d{9}');
    return regExp.hasMatch(value) && value.length == 11;
  }
}

class NationalCodeValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.length == 10;
  }
}

class SignupFieldValidator {
  final StringValidator firstnameValidator = NonEmptyStringValidator();
  final StringValidator lastnameValidator = NonEmptyStringValidator();
  final StringValidator usernameValidator = NonEmptyStringValidator();
  final StringValidator phoneNumberValidator = PhoneNumberStringValidator();
  final StringValidator nationalCodeValidator = NationalCodeValidator();
  final String inValidFirstnameErrorMassage = 'نام کوچک صحیح خود را وارد کنید';
  final String inValidLastnameErrorMassage = 'نام خوانوادگی صحیح خود را وارد کنید';
  final String inValidUsernameErrorMassage = 'نام کاربری صحیح خود را وارد کنید';
  final String inValidPhoneNumberErrorMassage = 'شماره همراه صحیح خود را وارد کنید';
  final String invalidNationalCodeErrorMassage = 'کد ملی خود را وارد کنید';
}

