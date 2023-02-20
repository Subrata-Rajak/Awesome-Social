import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/data/arguments/personal_bookmarks_view_arguments.dart';
import 'package:insta_clone/app/data/firebase/post_model.dart';
import 'package:insta_clone/app/modules/profile/controllers/profile_controller.dart';

import '../../../common/widgets/list items/post_list_item.dart';

class PersonalBookmarksView extends StatelessWidget {
  const PersonalBookmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as PersonalBookmarksViewArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView.separated(
        itemCount: ProfileController.instance.myBookmarks.length,
        itemBuilder: (context, index) {
          return PostListItem(
            post: args.listOfPostModels[index],
            authorProfImageUrl: args
                    .listOfPostModels[index].authorProfImageUrls[
                args.listOfPostModels[index].authorProfImageUrls.length - 1],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
