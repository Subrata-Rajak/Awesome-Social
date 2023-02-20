import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:insta_clone/app/data/firebase/post_model.dart';
import 'package:insta_clone/app/modules/feed/controllers/feed_controller.dart';
import 'package:insta_clone/app/modules/post/controllers/customize_post_controller.dart';
import 'package:insta_clone/app/modules/profile/controllers/profile_controller.dart';
import 'package:insta_clone/app/modules/search/controllers/search_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          body: controller.views[controller.selectedIndex.value],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: GNav(
              onTabChange: (index) {
                controller.selectedIndex.value = index;
                ProfileController.instance.myPosts.value = [];
                ProfileController.instance.myBookmarks.value = [];
                if (controller.selectedIndex.value != 1) {
                  SearchController.instance.searchController.clear();
                  SearchController.instance.isShowUser.value = false;
                }
              },
              tabBackgroundColor: Colors.grey.shade800,
              padding: const EdgeInsets.all(10),
              gap: 10,
              backgroundColor: Colors.black,
              tabs: controller.tabs,
              color: Colors.white,
              activeColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
