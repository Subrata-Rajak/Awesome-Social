import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:insta_clone/app/common/exceptions/auth_failure.dart';
import 'package:insta_clone/app/common/get%20storage/local_storage_repo.dart';
import 'package:insta_clone/app/common/utils/name_builder.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import 'firebase_storage_controller.dart';
import 'firestore_controller.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get instance =>
      Get.put(AuthenticationController());

  final box = GetStorage();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  String registerResponse = "Success";
  String loginResponse = "Success";

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? LocalStorageRepo.instance
            .writeData(key: AppStrings.getStorageIsLoggedInKey, value: false)
        : LocalStorageRepo.instance
            .writeData(key: AppStrings.getStorageIsLoggedInKey, value: true);
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
    required Uint8List file,
  }) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String photoUrl =
          await FirebaseStorageController.instance.uploadImageToStorage(
        childName: "profilePics",
        file: file,
        isPost: false,
      );

      FireStoreController.instance.storeUserDetails(
        uid: userCred.user!.uid,
        userName: userName,
        email: email,
        bio: AppStrings.userDefaultBio,
        followers: [],
        followings: [],
        posts: [],
        bookmarked: [],
        photoUrl: [photoUrl],
        authProvider: "Email",
        name: NameBuilder.buildNameFrom(userName),
        phoneNumber: "phone number",
        gender: "gender",
      );

      Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      registerResponse = AuthFailure.code(e.code).message;
    } catch (_) {
      registerResponse = const AuthFailure().message;
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      loginResponse = AuthFailure.code(e.code).message;
    } catch (_) {
      loginResponse = const AuthFailure().message;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
