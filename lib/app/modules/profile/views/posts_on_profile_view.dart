import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/data/arguments/personal_posts_view_arguments.dart';
import 'package:insta_clone/app/modules/profile/controllers/profile_controller.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import '../../../data/firebase/post_model.dart';

class PostsOnProfileView extends GetView {
  const PostsOnProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileController.instance.myPosts.isEmpty
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
            itemCount: ProfileController.instance.myPosts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.PERSONAL_POSTS,
                    arguments: PersonalPostsViewArguments(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  );
                },
                child: Image(
                  image: NetworkImage(
                    ProfileController.instance.myPosts[index].postPhotoUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              );
            },
          );
  }
}
