import 'package:email_validator/email_validator.dart';

class TextFieldValidator {
  TextFieldValidator get validator => TextFieldValidator();

  static String? userNameValidator(String? userName) {
    String? res = "Please Enter a user name";

    if (userName != null && userName.isNotEmpty) {
      res = null;
    }

    return res;
  }

  static String? emailValidator(String? email) {
    String? res = "Please Enter Email";

    if (email != null && email.isNotEmpty) {
      if (!EmailValidator.validate(email)) {
        res = "Please Enter a valid email";
      } else {
        res = null;
      }
    }

    return res;
  }

  static String? passwordValidator(String? password) {
    String? res = "Please enter a password";

    if (password != null && password.isNotEmpty) {
      RegExp atLeastOneUpperCase = RegExp(r'(?=.*?[A-Z])');
      RegExp atLeastOneLowerCase = RegExp(r'(?=.*[a-z])');
      RegExp atLeastOneDigit = RegExp(r'(?=.*?[0-9])');
      RegExp atLeastOneSpecialCharacter = RegExp(r'(?=.*?[!@#\$&*~])');
      RegExp minCharacter = RegExp(r'.{6,}');

      if (!minCharacter.hasMatch(password)) {
        res = "Password should have 6 or more characters";
      } else if (!atLeastOneUpperCase.hasMatch(password)) {
        res = "Password should have at least 1 uppercase character";
      } else if (!atLeastOneLowerCase.hasMatch(password)) {
        res = "Password should have at least 1 lowercase character";
      } else if (!atLeastOneDigit.hasMatch(password)) {
        res = "Password should have at least 1 digit";
      } else if (!atLeastOneSpecialCharacter.hasMatch(password)) {
        res = "Password should have at least 1 special character";
      } else {
        res = null;
      }
    }

    return res;
  }

  static String? confirmPasswordValidator(
      String? password, String? confirmPassword) {
    String? res = "Password and confirm password should match";

    if (password != null &&
        password.isNotEmpty &&
        confirmPassword != null &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        res = null;
      }
    }

    return res;
  }
}
