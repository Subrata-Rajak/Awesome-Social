import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/modules/feed/views/feed_view.dart';
import 'package:insta_clone/app/modules/follow/views/follow_view.dart';
import 'package:insta_clone/app/modules/post/views/post_view.dart';
import 'package:insta_clone/app/modules/profile/views/profile_view.dart';
import 'package:insta_clone/app/modules/search/views/search_view.dart';

import '../../../common/controllers/firebase/firestore_controller.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.put(HomeController());
  var selectedIndex = 0.obs;
  bool isVisited = false;

  List views = [
    FeedView(),
    SearchView(),
    const PostView(),
    FollowView(),
    ProfileView(),
  ];

  List<GButton> tabs = const [
    GButton(
      icon: Icons.home,
      text: AppStrings.feedBarTitle,
    ),
    GButton(
      icon: Icons.search_outlined,
      text: AppStrings.searchBarTitle,
    ),
    GButton(
      icon: Icons.add_circle_outline_outlined,
      text: AppStrings.postBarTitle,
    ),
    GButton(
      icon: Icons.favorite_outline_rounded,
      text: AppStrings.followBarTitle,
    ),
    GButton(
      icon: Icons.person_outline_rounded,
      text: AppStrings.profileBarTitle,
    ),
  ];
}
