import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/data/arguments/personal_posts_view_arguments.dart';
import 'package:insta_clone/app/modules/others_profile/controllers/others_profile_controller.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import '../../../common/utils/strings.dart';

class OtherPostOnOthersProfileView extends GetView {
  const OtherPostOnOthersProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OthersProfileController.instance.userPostsData.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.face,
                  size: 100,
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppStrings.postsOnProfileText,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.fromLTRB(
              10,
              10,
              10,
              0,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: OthersProfileController.instance.userPostsData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.PERSONAL_POSTS,
                    arguments: PersonalPostsViewArguments(
                      uid: OthersProfileController
                          .instance.userData[AppStrings.uidField],
                    ),
                  );
                },
                child: Image(
                  image: NetworkImage(
                    OthersProfileController
                        .instance.userPostsData[index].postPhotoUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              );
            },
          );
  }
}
