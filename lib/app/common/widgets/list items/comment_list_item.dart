import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/data/firebase/comment_model.dart';
import 'package:insta_clone/app/modules/comment/controllers/comment_controller.dart';
import 'package:intl/intl.dart';

import '../../../modules/others_profile/controllers/others_profile_controller.dart';
import '../../../routes/app_pages.dart';
import '../../utils/strings.dart';

class CommentListItem extends StatelessWidget {
  final CommentModel comment;
  final String postId;
  const CommentListItem({
    required this.comment,
    required this.postId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(AppStrings.userCollection)
                    .doc(comment.authorUid)
                    .snapshots(),
                builder: (
                  context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircleAvatar(
                      radius: 15,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () async {
                      Get.toNamed(Routes.OTHERS_PROFILE);
                      await OthersProfileController.instance
                          .getUserDetails(comment.authorUid);
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        snapshot.data![AppStrings.photoUrlField][
                            snapshot.data![AppStrings.photoUrlField].length -
                                1],
                      ),
                      radius: 15,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: "${comment.authorUserName} ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: comment.comment,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat.yMMMd()
                              .format(comment.datePublished.toDate()),
                          style: TextStyle(
                            color: Colors.grey.withOpacity(
                              0.7,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${comment.likes.length.toString()} likes',
                          style: TextStyle(
                            color: Colors.grey.withOpacity(
                              0.7,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              //Todo: implement likes update
              CommentController.instance.likeComment(
                postId,
                comment.commentId,
                FirebaseAuth.instance.currentUser!.uid,
                comment.likes,
              );
            },
            child: Icon(
              comment.likes.contains(FirebaseAuth.instance.currentUser!.uid)
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color:
                  comment.likes.contains(FirebaseAuth.instance.currentUser!.uid)
                      ? Colors.red
                      : Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
