import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/app/common/utils/strings.dart';

class PostModel {
  final String authorUid;
  final String authorUserName;
  final List authorProfImageUrls;
  final String postId;
  final String description;
  final String postPhotoUrl;
  final datePublished;
  final List likes;
  final List bookmarked;
  final List comments;

  PostModel({
    required this.authorUid,
    required this.authorUserName,
    required this.authorProfImageUrls,
    required this.postId,
    required this.description,
    required this.postPhotoUrl,
    required this.datePublished,
    required this.likes,
    required this.bookmarked,
    required this.comments,
  });

  Map<String, dynamic> toJson() => {
        AppStrings.authorUidField: authorUid,
        AppStrings.authorUserNameField: authorUserName,
        AppStrings.postIdField: postId,
        AppStrings.descriptionField: description,
        AppStrings.postPhotoUrlField: postPhotoUrl,
        AppStrings.datePublishedField: datePublished,
        AppStrings.likesField: likes,
        AppStrings.bookmarkedField: bookmarked,
        AppStrings.postCommentsField: comments,
        AppStrings.authorProImageUrlsField: authorProfImageUrls,
      };

  factory PostModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();

    return PostModel(
      authorUid: data![AppStrings.authorUidField],
      authorUserName: data[AppStrings.authorUserNameField],
      postId: data[AppStrings.postIdField],
      description: data[AppStrings.descriptionField],
      postPhotoUrl: data[AppStrings.postPhotoUrlField],
      datePublished: data[AppStrings.datePublishedField],
      likes: data[AppStrings.likesField],
      bookmarked: data[AppStrings.bookmarkedField],
      comments: data[AppStrings.postCommentsField],
      authorProfImageUrls: data [AppStrings.authorProImageUrlsField],
    );
  }
}
