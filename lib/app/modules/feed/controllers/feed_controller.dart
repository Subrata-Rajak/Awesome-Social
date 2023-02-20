import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/controllers/firebase/firestore_controller.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/data/firebase/post_model.dart';

class FeedController extends GetxController {
  static FeedController get instance => Get.put(FeedController());

  var allPostsData = List<PostModel>.empty().obs;
  var isLoading = false.obs;

  void getAllPostsDetails() async {
    isLoading.value = true;
    allPostsData.value = await FireStoreController.instance.getAllPostsData();
    isLoading.value = false;
  }

  Future<String> getCurrentUserProfileImageUrl() async {
    var snap = await FireStoreController.instance
        .getUserData(FirebaseAuth.instance.currentUser!.uid);

    var currentUserData = snap.data()!;

    return currentUserData[AppStrings.photoUrlField][currentUserData[AppStrings.photoUrlField].length - 1];
  }

  void updateLikes(
    String postId,
    String uid,
    List likes,
  ) async {
    await FireStoreController.instance.updateLikes(
      postId,
      uid,
      likes,
    );
  }

  void updateBookmarked(
    String postId,
    String uid,
    List bookmarked,
  ) async {
    await FireStoreController.instance.updateBookmarked(
      postId,
      uid,
      bookmarked,
    );
  }
}
