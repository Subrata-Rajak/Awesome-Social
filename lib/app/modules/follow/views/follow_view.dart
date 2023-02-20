import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/widgets/custom/custom_follow_screen_tiles.dart';
import 'package:insta_clone/app/common/widgets/list%20items/user_list_item.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import '../../../common/utils/strings.dart';
import '../controllers/follow_controller.dart';

class FollowView extends GetView<FollowController> {
  final FollowController _controller = Get.put(FollowController());

  FollowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (_controller.isFirstTime) {
      _controller.getAllUserDetails();
    }

    //bool isFollowing = false;

    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(AppStrings.followBarTitle),
            ),
            backgroundColor: Colors.black,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFollowScreenTile(
                  tileTitle: "Followers",
                  route: Routes.FOLLOWERS,
                ),
                CustomFollowScreenTile(
                  tileTitle: "Following",
                  route: Routes.FOLLOWING,
                ),
                const Text(
                  "You might follow",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: _controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: _controller.allUserData.length,
                          itemBuilder: (context, index) {
                            return UserListItem(
                              user: _controller.allUserData[index],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
