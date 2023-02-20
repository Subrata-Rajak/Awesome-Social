import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/data/firebase/post_model.dart';
import 'package:insta_clone/app/modules/others_profile/views/other_post_on_others_profile_view.dart';

import '../../../common/controllers/firebase/firestore_controller.dart';
import '../../profile/views/bookmarks_view.dart';
import '../../profile/views/tagged_posts_view.dart';

class OthersProfileController extends GetxController {
  static OthersProfileController get instance =>
      Get.put(OthersProfileController());

  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  var isFollowing = false.obs;
  var userPostsData = List<PostModel>.empty().obs;

  var userData = {};
  var currentUserData = {};

  Future<void> getUserDetails(String uid) async {
    isLoading.value = true;
    var snap = await FireStoreController.instance.getUserData(uid);

    userData = snap.data()!;

    var currentUserSnap = await FireStoreController.instance
        .getUserData(FirebaseAuth.instance.currentUser!.uid);

    currentUserData = currentUserSnap.data()!;

    followingChecker();

    for (var i = 0; i < userData[AppStrings.postsField].length; i++) {
      var snap = await FireStoreController.instance
          .getSinglePostDetails(userData[AppStrings.postsField][i]);

      var postData = snap.data()!;

      PostModel post = PostModel(
        authorUid: postData[AppStrings.authorUidField],
        authorUserName: postData[AppStrings.authorUserNameField],
        postId: postData[AppStrings.postIdField],
        description: postData[AppStrings.descriptionField],
        postPhotoUrl: postData[AppStrings.postPhotoUrlField],
        datePublished: postData[AppStrings.datePublishedField],
        likes: postData[AppStrings.likesField],
        bookmarked: postData[AppStrings.bookmarkedField],
        comments: postData[AppStrings.postCommentsField],
        authorProfImageUrls: postData[AppStrings.authorProImageUrlsField],
      );

      userPostsData.add(post);
    }

    isLoading.value = false;
  }

  void followingChecker() async {
    for (var i = 0;
        i < currentUserData[AppStrings.followingsField].length;
        i++) {
      if (userData[AppStrings.uidField] ==
          currentUserData[AppStrings.followingsField][i]) {
        isFollowing.value = true;
        break;
      }
    }
  }

  List<TabItem> tabs = const [
    TabItem(
      icon: Icons.apps_sharp,
    ),
    TabItem(
      icon: Icons.bookmark,
    ),
    TabItem(
      icon: Icons.person,
    ),
  ];

  List views = [
    const OtherPostOnOthersProfileView(),
    const BookmarksView(),
    const TaggedPostsView(),
  ];
}
