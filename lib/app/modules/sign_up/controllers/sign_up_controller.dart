import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/controllers/firebase/authentication_controller.dart';
import '../../../common/controllers/ui/image_picker_controller.dart';
import '../../../common/controllers/ui/textfield_validator.dart';

class SignUpController extends GetxController {
  var userNameTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var confirmPasswordTextController = TextEditingController();

  var isUserNameFocused = false.obs;
  var isEmailFocused = false.obs;
  var isPasswordFocused = false.obs;
  var isConfirmPasswordFocused = false.obs;

  var image = Uint8List(0).obs;

  void selectImage() async {
    Uint8List im =
        await ImagePickerController.instance.pickImage(ImageSource.gallery);
    image.value = im;
  }

  String registerCall({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
    required Uint8List file,
  }) {
    String res = "";

    if (TextFieldValidator.userNameValidator(userName) != null) {
      res = TextFieldValidator.userNameValidator(userName)!;
    } else if (TextFieldValidator.emailValidator(email) != null) {
      res = TextFieldValidator.emailValidator(email)!;
    } else if (TextFieldValidator.passwordValidator(password) != null) {
      res = TextFieldValidator.passwordValidator(password)!;
    } else if (TextFieldValidator.confirmPasswordValidator(
          password,
          confirmPassword,
        ) !=
        null) {
      res = TextFieldValidator.confirmPasswordValidator(
        password,
        confirmPassword,
      )!;
    } else if (file.isEmpty) {
      res = "Please choose a profile picture";
    } else {
      registerUser(
        email,
        password,
        confirmPassword,
        userName,
        file,
      );

      res = AuthenticationController.instance.registerResponse;
    }

    return res;
  }

  Future<void> registerUser(
    String email,
    String password,
    String confirmPassword,
    String userName,
    Uint8List file,
  ) async {
    await AuthenticationController.instance.registerUser(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      userName: userName,
      file: file,
    );
  }
}
