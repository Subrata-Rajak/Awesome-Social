import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/widgets/list%20items/post_list_item.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import '../../../common/utils/strings.dart';
import '../../../data/firebase/post_model.dart';
import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  final FeedController _controller = Get.put(FeedController());

  FeedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getAllPostsDetails();

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(AppStrings.feedBarTitle),
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Get.toNamed(Routes.CHAT);
              },
              icon: const FaIcon(
                FontAwesomeIcons.facebookMessenger,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(AppStrings.postsCollection)
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
                    posts[index].authorProfImageUrls.length - 1],
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
