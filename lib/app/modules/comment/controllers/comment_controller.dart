import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/controllers/firebase/firestore_controller.dart';

class CommentController extends GetxController {
  static CommentController get instance => Get.put(CommentController());

  final TextEditingController commentController = TextEditingController();
  var isFocused = false.obs;
  var isLoading = false.obs;

  Future<void> postComment({
    required String postId,
    required String commentId,
    required String comment,
    required String authorUserName,
    required String authorUid,
    required datePublished,
    required List likes,
  }) async {
    isLoading.value = true;
    await FireStoreController.instance.storeComment(
      postId: postId,
      commentId: commentId,
      comment: comment,
      authorUserName: authorUserName,
      authorUid: authorUid,
      datePublished: datePublished,
      likes: likes,
    );
    isLoading.value = false;
  }

  void likeComment(
    String postId,
    String commentId,
    String uid,
    List likes,
  ) async {
    await FireStoreController.instance.updateCommentLikes(
      postId,
      commentId,
      uid,
      likes,
    );
  }

  var currentUserData = {};

  Future<void> getCurrentUserDetails() async {
    var snap = await FireStoreController.instance
        .getUserData(FirebaseAuth.instance.currentUser!.uid);

    currentUserData = snap.data()!;
  }
}
