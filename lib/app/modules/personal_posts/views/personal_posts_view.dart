import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/data/arguments/personal_posts_view_arguments.dart';
import 'package:insta_clone/app/modules/personal_posts/controllers/personal_posts_controller.dart';

import '../../../common/utils/strings.dart';
import '../../../common/widgets/list items/post_list_item.dart';
import '../../../data/firebase/post_model.dart';

class PersonalPostsView extends GetView<PersonalPostsController> {
  const PersonalPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as PersonalPostsViewArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(AppStrings.postsCollection)
            .where(
              AppStrings.authorUidField,
              isEqualTo: args.uid,
            )
            .snapshots(),
        builder: (
          context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              List<PostModel> posts = snapshot.data!.docs
                  .map((e) => PostModel.fromSnapShot(e))
                  .toList();
              return PostListItem(
                post: posts[index],
                authorProfImageUrl: posts[index].authorProfImageUrls[
                    posts[index].authorProfImageUrls.length -
                        1], 
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 20,
              );
            },
          );
        },
      ),
    );
  }
}
