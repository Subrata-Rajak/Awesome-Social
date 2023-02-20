import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/controllers/firebase/firebase_storage_controller.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/data/firebase/comment_model.dart';
import 'package:insta_clone/app/data/firebase/message_model.dart';
import 'package:insta_clone/app/data/firebase/post_model.dart';
import 'package:uuid/uuid.dart';

import '../../../data/firebase/user_model.dart';

class FireStoreController extends GetxController {
  static FireStoreController get instance => Get.put(FireStoreController());
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> storeUserDetails({
    required String uid,
    required String userName,
    required String email,
    required String bio,
    required List followers,
    required List followings,
    required List posts,
    required List bookmarked,
    required List photoUrl,
    required String authProvider,
    required String name,
    required String phoneNumber,
    required String gender,
  }) async {
    try {
      await _firebaseFirestore
          .collection(AppStrings.userCollection)
          .doc(uid)
          .set(UserModel(
            uid: uid,
            name: name,
            phoneNumber: phoneNumber,
            gender: gender,
            userName: userName,
            email: email,
            bio: bio,
            followers: followers,
            followings: followings,
            posts: posts,
            bookmarked: bookmarked,
            photoUrls: photoUrl,
            authProvider: authProvider,
          ).toJson());
    } catch (error) {
      print(error.toString());
    }
  }

  Future<dynamic> getUserData(String uid) async {
    var snap;

    try {
      snap = await _firebaseFirestore
          .collection(AppStrings.userCollection)
          .doc(uid)
          .get();
    } catch (error) {
      print(error.toString());
    }

    return snap;
  }

  Future<List<UserModel>> getAllUserData() async {
    final snapShot =
        await _firebaseFirestore.collection(AppStrings.userCollection).get();

    final allUserData =
        snapShot.docs.map((e) => UserModel.fromSnapShot(e)).toList();

    return allUserData;
  }

  Future<List<PostModel>> getAllPostsData() async {
    final snapShot =
        await _firebaseFirestore.collection(AppStrings.postsCollection).get();

    final allPostsData =
        snapShot.docs.map((e) => PostModel.fromSnapShot(e)).toList();

    return allPostsData;
  }

  Future<void> updateFollowingList(
    List followingsList,
    String followingUid,
  ) async {
    followingsList.add(followingUid);

    try {
      await _firebaseFirestore
          .collection(AppStrings.userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({AppStrings.followingsField: followingsList});
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> updateFollowersList(
    List followersList,
    String followingUid,
  ) async {
    followersList.add(FirebaseAuth.instance.currentUser!.uid);

    try {
      await _firebaseFirestore
          .collection(AppStrings.userCollection)
          .doc(followingUid)
          .update({AppStrings.followersField: followersList});
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> unFollowUser(
    List followingsList,
    List followersList,
    String uid,
  ) async {
    try {
      await _firebaseFirestore
          .collection(AppStrings.userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({AppStrings.followingsField: followingsList});

      await _firebaseFirestore
          .collection(AppStrings.userCollection)
          .doc(uid)
          .update({AppStrings.followersField: followersList});
    } catch (error) {
      print(error.toString());
    }
  }

  Future<String> storePost({
    required String authorUid,
    required String authorUserName,
    required Uint8List file,
    required String description,
    required String authorProfileImageUrl,
  }) async {
    String postId = "";

    try {
      String postPhotoUrl = await FirebaseStorageController.instance
          .uploadImageToStorage(childName: 'posts', file: file, isPost: true);

      postId = const Uuid().v1();

      PostModel post = PostModel(
        authorUid: authorUid,
        authorUserName: authorUserName,
        postId: postId,
        description: description,
        postPhotoUrl: postPhotoUrl,
        datePublished: DateTime.now(),
        likes: [],
        bookmarked: [],
        comments: [],
        authorProfImageUrls: [authorProfileImageUrl],
      );

      _firebaseFirestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .set(post.toJson());
    } catch (error) {
      print(error.toString());
    }

    return postId;
  }

  Future<void> updatePostAuthorProfImageList({
    required String authorProfImageUrl,
    required List postIdList,
  }) async {
    try {
      for (var i = 0; i < postIdList.length; i++) {
        _firebaseFirestore
            .collection(AppStrings.postsCollection)
            .doc(postIdList[i])
            .update(
          {
            AppStrings.authorProImageUrlsField: FieldValue.arrayUnion(
              [authorProfImageUrl],
            ),
          },
        );
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> updatePostDetailsOfUser(String uid, String postId) async {
    final docRef =
        _firebaseFirestore.collection(AppStrings.userCollection).doc(uid);

    var snap = await docRef.get();
    var userData = snap.data()!;

    userData[AppStrings.postsField].add(postId);

    docRef.update({AppStrings.postsField: userData[AppStrings.postsField]});
  }

  Future<dynamic> getSinglePostDetails(String postId) async {
    var snap;

    try {
      snap = await _firebaseFirestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .get();
    } catch (error) {
      print(error.toString());
    }

    return snap;
  }

  Future<void> updateLikes(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firebaseFirestore
            .collection(AppStrings.postsCollection)
            .doc(postId)
            .update({
          AppStrings.likesField: FieldValue.arrayRemove([uid])
        });
      } else {
        await _firebaseFirestore
            .collection(AppStrings.postsCollection)
            .doc(postId)
            .update({
          AppStrings.likesField: FieldValue.arrayUnion([uid])
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> storeComment({
    required String postId,
    required String commentId,
    required String comment,
    required String authorUserName,
    required String authorUid,
    required datePublished,
    required List likes,
  }) async {
    try {
      await _firebaseFirestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .collection(AppStrings.commentsCollection)
          .doc(commentId)
          .set(CommentModel(
            commentId: commentId,
            comment: comment,
            authorUserName: authorUserName,
            authorUid: authorUid,
            datePublished: datePublished,
            likes: likes,
          ).toJson());

      var postCommentId = const Uuid().v1();

      await _firebaseFirestore
          .collection(AppStrings.postsCollection)
          .doc(postId)
          .update({
        AppStrings.postCommentsField: FieldValue.arrayUnion(
            ["$postCommentId, ${FirebaseAuth.instance.currentUser!.uid}"])
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> updateCommentLikes(
    String postId,
    String commentId,
    String uid,
    List likes,
  ) async {
    try {
      if (likes.contains(uid)) {
        await _firebaseFirestore
            .collection(AppStrings.postsCollection)
            .doc(postId)
            .collection(AppStrings.commentsCollection)
            .doc(commentId)
            .update({
          AppStrings.likesField: FieldValue.arrayRemove([uid])
        });
      } else {
        await _firebaseFirestore
            .collection(AppStrings.postsCollection)
            .doc(postId)
            .collection(AppStrings.commentsCollection)
            .doc(commentId)
            .update({
          AppStrings.likesField: FieldValue.arrayUnion([uid])
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> updateBookmarked(
    String postId,
    String uid,
    List bookmarked,
  ) async {
    try {
      if (bookmarked.contains(uid)) {
        await _firebaseFirestore
            .collection(AppStrings.postsCollection)
            .doc(postId)
            .update(
          {
            AppStrings.bookmarkedField: FieldValue.arrayRemove(
              [uid],
            ),
          },
        );

        await _firebaseFirestore
            .collection(AppStrings.userCollection)
            .doc(uid)
            .update(
          {
            AppStrings.bookmarkedField: FieldValue.arrayRemove(
              [postId],
            ),
          },
        );
      } else {
        await _firebaseFirestore
            .collection(AppStrings.postsCollection)
            .doc(postId)
            .update(
          {
            AppStrings.bookmarkedField: FieldValue.arrayUnion(
              [uid],
            ),
          },
        );

        await _firebaseFirestore
            .collection(AppStrings.userCollection)
            .doc(uid)
            .update(
          {
            AppStrings.bookmarkedField: FieldValue.arrayUnion(
              [postId],
            ),
          },
        );
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> addNewProfilePic({
    required Uint8List file,
  }) async {
    String photoUrl =
        await FirebaseStorageController.instance.uploadImageToStorage(
      childName: "profilePics",
      file: file,
      isPost: false,
    );

    await _firebaseFirestore
        .collection(AppStrings.userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {
        AppStrings.photoUrlField: FieldValue.arrayUnion(
          [photoUrl],
        ),
      },
    );
  }

  Future<void> upDateUserProfileDetails(
    Uint8List? file,
    String? name,
    String? userName,
    String? bio,
    String? phoneNumber,
    String? gender,
  ) async {
    try {
      if (file != null) {
        String photoUrl =
            await FirebaseStorageController.instance.uploadImageToStorage(
          childName: "profilePics",
          file: file,
          isPost: false,
        );

        await _firebaseFirestore
            .collection(AppStrings.userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          AppStrings.photoUrlField: FieldValue.arrayUnion([photoUrl]),
        });

        var snap = await _firebaseFirestore
            .collection(AppStrings.userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

        final userData = snap.data()!;

        await updatePostAuthorProfImageList(
          authorProfImageUrl: photoUrl,
          postIdList: userData[AppStrings.postsField],
        );
      }

      if (name != null) {
        await _firebaseFirestore
            .collection(AppStrings.userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          AppStrings.nameField: name,
        });
      }

      if (bio != null) {
        await _firebaseFirestore
            .collection(AppStrings.userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          AppStrings.bioField: bio,
        });
      }

      if (phoneNumber != null) {
        await _firebaseFirestore
            .collection(AppStrings.userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          AppStrings.phoneNumberField: phoneNumber,
        });
      }

      if (gender != null) {
        await _firebaseFirestore
            .collection(AppStrings.userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          AppStrings.genderField: gender,
        });
      }

      if (userName != null) {
        await _firebaseFirestore
            .collection(AppStrings.userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          AppStrings.userNameField: userName,
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> storeMessages({
    required String currentUserUid,
    required String firstPersonUid,
    required String senderUid,
    required String receiverUid,
    required String message,
    required datePublished,
  }) async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection(AppStrings.messagesCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(firstPersonUid)
          .get();

      final messageNum = snap.docs.length;

      await _firebaseFirestore
          .collection(AppStrings.messagesCollection)
          .doc(currentUserUid)
          .collection(firstPersonUid)
          .doc(messageNum.toString())
          .set(MessageModel(
            senderUid: senderUid,
            receiverUid: receiverUid,
            message: message,
            datePublished: datePublished,
            messageNumber: messageNum,
          ).toJson());

      await _firebaseFirestore
          .collection(AppStrings.messagesCollection)
          .doc(firstPersonUid)
          .collection(currentUserUid)
          .doc(messageNum.toString())
          .set(MessageModel(
            senderUid: senderUid,
            receiverUid: receiverUid,
            message: message,
            datePublished: datePublished,
            messageNumber: messageNum,
          ).toJson());
    } catch (error) {
      print(error.toString());
    }
  }
}
