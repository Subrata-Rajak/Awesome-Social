import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/data/arguments/personal_bookmarks_view_arguments.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import '../../../common/utils/strings.dart';
import '../controllers/profile_controller.dart';

class BookmarksView extends GetView {
  const BookmarksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProfileController.instance.myBookmarks.isEmpty
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
                  AppStrings.bookmarkedPostsText,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          )
        : ProfileController.instance.isGettingBookMarks.value
            ? const Center(
                child: CircularProgressIndicator(),
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
                itemCount: ProfileController.instance.myBookmarks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.PERSONAL_BOOKMARKS,
                        arguments: PersonalBookmarksViewArguments(
                          listOfPostModels:
                              ProfileController.instance.myBookmarks,
                        ),
                      );
                    },
                    child: Image(
                      image: NetworkImage(
                        ProfileController
                            .instance.myBookmarks[index].postPhotoUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
  }
}
