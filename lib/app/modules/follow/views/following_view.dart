import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/widgets/list%20items/followings_list_item.dart';
import 'package:insta_clone/app/modules/follow/controllers/follow_controller.dart';

import '../../../common/utils/strings.dart';

class FollowingView extends GetView {
  final FollowController _followController = Get.put(FollowController());

  FollowingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            bottom: PreferredSize(
              preferredSize: const Size(0, 0),
              child: Container(
                height: 0.2,
                color: Colors.white,
              ),
            ),
            title: const Text(
              AppStrings.followingBarTitle,
            ),
            leading: IconButton(
              onPressed: () {
                _followController.allFollowingsData.value = [];
                _followController.getAllUserDetails();
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
          body: _followController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    10,
                    20,
                    0,
                  ),
                  itemCount: _followController.allFollowingsData.length,
                  itemBuilder: (context, index) {
                    return FollowingsListItem(
                      user: _followController.allFollowingsData[index],
                    );
                  },
                ),
        );
      },
    );
  }
}
