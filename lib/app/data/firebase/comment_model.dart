import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/app/common/utils/strings.dart';

class CommentModel {
  final String commentId;
  final String comment;
  final String authorUserName;
  final String authorUid;
  final datePublished;
  final List likes;

  CommentModel({
    required this.commentId,
    required this.comment,
    required this.authorUserName,
    required this.authorUid,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        AppStrings.commentIdField: commentId,
        AppStrings.commentField: comment,
        AppStrings.authorUserNameField: authorUserName,
        AppStrings.authorUidField: authorUid,
        AppStrings.datePublishedField: datePublished,
        AppStrings.likesField: likes,
      };

  factory CommentModel.fromSnapShot(
    DocumentSnapshot<Map<String, dynamic>> snap,
  ) {
    final data = snap.data();
    return CommentModel(
      commentId: data![AppStrings.commentIdField],
      comment: data[AppStrings.commentField],
      authorUserName: data[AppStrings.authorUserNameField],
      authorUid: data[AppStrings.authorUidField],
      datePublished: data[AppStrings.datePublishedField],
      likes: data[AppStrings.likesField],
    );
  }
}
