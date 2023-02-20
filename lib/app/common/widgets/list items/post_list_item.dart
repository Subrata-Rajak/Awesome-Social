import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/data/arguments/comment_view_arguments.dart';
import 'package:insta_clone/app/data/firebase/post_model.dart';
import 'package:insta_clone/app/modules/comment/controllers/comment_controller.dart';
import 'package:insta_clone/app/modules/feed/controllers/feed_controller.dart';
import 'package:intl/intl.dart';

import '../../../modules/others_profile/controllers/others_profile_controller.dart';
import '../../../routes/app_pages.dart';

class PostListItem extends StatelessWidget {
  final PostModel post;
  final String authorProfImageUrl;

  const PostListItem({
    required this.post,
    required this.authorProfImageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 480,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  Get.toNamed(Routes.OTHERS_PROFILE);
                  await OthersProfileController.instance
                      .getUserDetails(post.authorUid);
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    authorProfImageUrl,
                  ),
                  radius: 25,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                post.authorUserName,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  post.postPhotoUrl,
                ),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  5,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      FeedController.instance.updateLikes(
                        post.postId,
                        FirebaseAuth.instance.currentUser!.uid,
                        post.likes,
                      );
                    },
                    child: Icon(
                      post.likes.contains(
                        FirebaseAuth.instance.currentUser!.uid,
                      )
                          ? Icons.favorite
                          : Icons.favorite_outline_outlined,
                      size: 25,
                      color: post.likes.contains(
                        FirebaseAuth.instance.currentUser!.uid,
                      )
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await CommentController.instance.getCurrentUserDetails();
                      Get.toNamed(
                        Routes.COMMENT,
                        arguments: CommentViewArguments(
                          post: post,
                        ),
                      );
                    },
                    child: const Icon(
                      FontAwesomeIcons.comment,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      FontAwesomeIcons.paperPlane,
                      size: 25,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  FeedController.instance.updateBookmarked(
                    post.postId,
                    FirebaseAuth.instance.currentUser!.uid,
                    post.bookmarked,
                  );
                },
                child: Icon(
                  post.bookmarked
                          .contains(FirebaseAuth.instance.currentUser!.uid)
                      ? Icons.bookmark
                      : Icons.bookmark_outline_outlined,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${post.likes.length.toString()} likes',
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 35,
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: '${post.authorUserName} ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: post.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () async {
              await CommentController.instance.getCurrentUserDetails();
              Get.toNamed(
                Routes.COMMENT,
                arguments: CommentViewArguments(
                  post: post,
                ),
              );
            },
            child: Text(
              "View all ${post.comments.length.toString()} comments",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withOpacity(
                  0.4,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              await CommentController.instance.getCurrentUserDetails();
              Get.toNamed(
                Routes.COMMENT,
                arguments: CommentViewArguments(
                  post: post,
                ),
              );
            },
            child: Text(
              "Add a comment...",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withOpacity(
                  0.4,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            DateFormat.yMMMd().format(post.datePublished.toDate()),
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.withOpacity(
                0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
