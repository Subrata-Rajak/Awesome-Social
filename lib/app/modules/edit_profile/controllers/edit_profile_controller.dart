import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/controllers/firebase/authentication_controller.dart';
import '../../../common/controllers/firebase/firestore_controller.dart';
import '../../../common/utils/strings.dart';
import 'package:insta_clone/app/modules/profile/controllers/profile_controller.dart';

import '../../../common/controllers/ui/image_picker_controller.dart';

class EditProfileController extends GetxController {
  var nameTextEditingController = TextEditingController();
  var userNameTextEditingController = TextEditingController();
  var bioTextEditingController = TextEditingController();
  var emailTextEditingController = TextEditingController();
  var phoneTextEditingController = TextEditingController();
  var genderTextEditingController = TextEditingController();

  var isLoading = false.obs;
  var newProfPic = Uint8List(0).obs;

  void selectImage() async {
    Uint8List im =
        await ImagePickerController.instance.pickImage(ImageSource.gallery);
    newProfPic.value = im;
  }

  Future<String> updateUserDetails() async {
    isLoading.value = true;
    String res = "Some error occurred";

    try {
      await FireStoreController.instance.upDateUserProfileDetails(
        newProfPic.value.isEmpty ? null : newProfPic.value,
        ProfileController.instance.userData[AppStrings.nameField] ==
                nameTextEditingController.text
            ? null
            : nameTextEditingController.text,
        ProfileController.instance.userData[AppStrings.userNameField] ==
                userNameTextEditingController.text
            ? null
            : userNameTextEditingController.text,
        ProfileController.instance.userData[AppStrings.bioField] ==
                bioTextEditingController.text
            ? null
            : bioTextEditingController.text,
        ProfileController.instance.userData[AppStrings.phoneNumberField] ==
                phoneTextEditingController.text
            ? null
            : phoneTextEditingController.text,
        ProfileController.instance.userData[AppStrings.genderField] ==
                genderTextEditingController.text
            ? null
            : genderTextEditingController.text,
      );

      await ProfileController.instance
          .getUserDetails(isSubmitButtonClicked: true);
      res = "Success";
    } catch (error) {
      print(error.toString());
    }

    isLoading.value = false;
    return res;
  }

  bool isStatusChanged() {
    bool res = false;

    if (newProfPic.value.isNotEmpty ||
        nameTextEditingController.text !=
            ProfileController.instance.userData[AppStrings.nameField] ||
        userNameTextEditingController.text !=
            ProfileController.instance.userData[AppStrings.userNameField] ||
        bioTextEditingController.text !=
            ProfileController.instance.userData[AppStrings.bioField] ||
        phoneTextEditingController.text !=
            ProfileController.instance.userData[AppStrings.phoneNumberField] ||
        genderTextEditingController.text !=
            ProfileController.instance.userData[AppStrings.genderField]) {
      res = true;
    }

    return res;
  }

  void logoutUser() {
    AuthenticationController.instance.logout();
  }

  void addNewProfilePic({
    required Uint8List file,
  }) async {
    await FireStoreController.instance.addNewProfilePic(
      file: file,
    );
  }
}
