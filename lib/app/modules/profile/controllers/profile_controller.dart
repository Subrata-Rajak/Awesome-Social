import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/controllers/firebase/firestore_controller.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/data/firebase/post_model.dart';
import 'package:insta_clone/app/modules/profile/views/bookmarks_view.dart';
import 'package:insta_clone/app/modules/profile/views/posts_on_profile_view.dart';
import 'package:insta_clone/app/modules/profile/views/tagged_posts_view.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.put(ProfileController());
  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  var isGettingBookMarks = false.obs;
  var myPosts = List<PostModel>.empty().obs;
  var myBookmarks = List<PostModel>.empty().obs;

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
    const PostsOnProfileView(),
    const BookmarksView(),
    const TaggedPostsView(),
  ];

  // @override
  // void onReady() {
  //   super.onReady();
  //   getUserDetails();
  // }

  var userData = {};

  Future<void> getUserDetails({
    required bool isSubmitButtonClicked,
  }) async {
    isLoading.value = true;
    var snap = await FireStoreController.instance
        .getUserData(FirebaseAuth.instance.currentUser!.uid);

    userData = snap.data()!;

    if (!isSubmitButtonClicked) {
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

        myPosts.add(post);
      }

      for (var i = 0; i < userData[AppStrings.bookmarkedField].length; i++) {
        var snap = await FireStoreController.instance
            .getSinglePostDetails(userData[AppStrings.bookmarkedField][i]);

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

        myBookmarks.add(post);
      }
    }
    isLoading.value = false;
  }
}
