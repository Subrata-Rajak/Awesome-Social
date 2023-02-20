import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/controllers/firebase/authentication_controller.dart';

import '../../../common/controllers/ui/textfield_validator.dart';

class LoginController extends GetxController {
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  var isEmailFocused = false.obs;
  var isPasswordFocused = false.obs;

  String loginCall({
    required String email,
    required String password,
  }) {
    String res = "Success";

    if (TextFieldValidator.emailValidator(email) != null) {
      res = TextFieldValidator.emailValidator(email)!;
    } else if (TextFieldValidator.passwordValidator(password) != null) {
      res = TextFieldValidator.passwordValidator(password)!;
    } else {
      loginUser(
        email: email,
        password: password,
      );
      res = AuthenticationController.instance.loginResponse;
    }

    return res;
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await AuthenticationController.instance
        .loginUser(email: email, password: password);
  }
}
