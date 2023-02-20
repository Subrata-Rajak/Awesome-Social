import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/widgets/list%20items/followers_list_item.dart';

import '../../../common/utils/strings.dart';
import '../controllers/follow_controller.dart';

class FollowersView extends GetView {
  final FollowController _followController = Get.put(FollowController());

  FollowersView({Key? key}) : super(key: key);
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
              AppStrings.followersBarTitle,
            ),
            leading: IconButton(
              onPressed: () {
                _followController.allFollowersData.value = [];
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
                  itemCount: _followController.allFollowersData.length,
                  itemBuilder: (context, index) {
                    return FollowersListItem(
                      user: _followController.allFollowersData[index],
                    );
                  },
                ),
        );
      },
    );
  }
}
