import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/widgets/list%20items/comment_list_item.dart';
import 'package:insta_clone/app/data/arguments/comment_view_arguments.dart';
import 'package:insta_clone/app/data/firebase/comment_model.dart';
import 'package:uuid/uuid.dart';

import '../../../common/utils/strings.dart';
import '../../../routes/app_pages.dart';
import '../../others_profile/controllers/others_profile_controller.dart';
import '../controllers/comment_controller.dart';

class CommentView extends GetView<CommentController> {
  const CommentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CommentViewArguments;

    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              AppStrings.commentBarTitle,
            ),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.paperPlane,
                ),
              ),
            ],
            bottom: controller.isLoading.value
                ? const PreferredSize(
                    preferredSize: Size(
                      0,
                      0,
                    ),
                    child: LinearProgressIndicator(),
                  )
                : null,
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(AppStrings.userCollection)
                            .doc(args.post.authorUid)
                            .snapshots(),
                        builder: (
                          context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot,
                        ) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircleAvatar(
                              radius: 25,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: () async {
                              Get.toNamed(Routes.OTHERS_PROFILE);
                              await OthersProfileController.instance
                                  .getUserDetails(args.post.authorUid);
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data![AppStrings.photoUrlField][
                                    snapshot.data![AppStrings.photoUrlField]
                                            .length -
                                        1],
                              ),
                              radius: 25,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            args.post.authorUserName,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 250,
                            child: Text(
                              args.post.description,
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(AppStrings.postsCollection)
                        .doc(args.post.postId)
                        .collection(AppStrings.commentsCollection)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          20,
                          20,
                          0,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          List<CommentModel> comments = snapshot.data!.docs
                              .map((e) => CommentModel.fromSnapShot(e))
                              .toList();
                          return CommentListItem(
                            comment: comments[index],
                            postId: args.post.postId,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 30,
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(AppStrings.userCollection)
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (
                            context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot,
                          ) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircleAvatar(
                                radius: 25,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data![AppStrings.photoUrlField][
                                    snapshot.data![AppStrings.photoUrlField]
                                            .length -
                                        1],
                              ),
                              radius: 25,
                            );
                          },
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: controller.commentController,
                            decoration: InputDecoration(
                              hintMaxLines: 2,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              hintText:
                                  "Add a comment for ${args.post.authorUserName}",
                            ),
                            maxLines: 2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (controller.commentController.text.isNotEmpty) {
                              final String commentId = const Uuid().v1();
                              await controller.postComment(
                                postId: args.post.postId,
                                commentId: commentId,
                                comment: controller.commentController.text,
                                authorUserName: controller
                                    .currentUserData[AppStrings.userNameField],
                                authorUid: controller
                                    .currentUserData[AppStrings.uidField],
                                datePublished: DateTime.now(),
                                likes: [],
                              );

                              controller.commentController.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          child: const Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
