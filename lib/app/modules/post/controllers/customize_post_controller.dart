import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/app/common/controllers/firebase/firestore_controller.dart';
import 'package:insta_clone/app/common/utils/strings.dart';

import '../../../common/controllers/ui/image_picker_controller.dart';

class CustomizePostController extends GetxController {
  static CustomizePostController get instance =>
      Get.put(CustomizePostController());

  var image = Uint8List(0).obs;
  var isLoading = false.obs;
  var res = "Posted!";

  final descriptionController = TextEditingController();

  void selectImage() async {
    Uint8List? im =
        await ImagePickerController.instance.pickImage(ImageSource.gallery);

    if (im != null) {
      image.value = im;
    }
  }

  var currentUserData = {};

  Future<void> getCurrentUserData() async {
    var snap = await FireStoreController.instance
        .getUserData(FirebaseAuth.instance.currentUser!.uid);

    currentUserData = snap.data()!;
  }

  Future<void> storePost() async {
    isLoading.value = true;

    if (image.value.isEmpty) {
      res = "Select an Image First";
    } else if (descriptionController.text.isEmpty) {
      res = "Enter an description first";
    } else {
      await getCurrentUserData();
      String postId = await FireStoreController.instance.storePost(
        authorUid: currentUserData[AppStrings.uidField],
        authorUserName: currentUserData[AppStrings.userNameField],
        file: image.value,
        description: descriptionController.text,
        authorProfileImageUrl: currentUserData[AppStrings.photoUrlField]
            [currentUserData[AppStrings.photoUrlField].length - 1],
      );

      if (postId != "") {
        await FireStoreController.instance.updatePostDetailsOfUser(
          FirebaseAuth.instance.currentUser!.uid,
          postId,
        );
      }
    }

    res = "Posted!";
    isLoading.value = false;
  }
}
