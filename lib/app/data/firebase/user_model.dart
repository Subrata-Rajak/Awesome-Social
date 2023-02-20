import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/utils/strings.dart';

class UserModel {
  final String uid;
  final String userName;
  final String email;
  final String bio;
  final List followers;
  final List followings;
  final List posts;
  final List bookmarked;
  final List photoUrls;
  final String authProvider;
  final String phoneNumber;
  final String name;
  final String gender;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.bio,
    required this.followers,
    required this.followings,
    required this.posts,
    required this.bookmarked,
    required this.photoUrls,
    required this.authProvider,
    required this.name,
    required this.phoneNumber,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        AppStrings.uidField: uid,
        AppStrings.authProviderField: authProvider,
        AppStrings.nameField: name,
        AppStrings.userNameField: userName,
        AppStrings.bioField: bio,
        AppStrings.genderField: gender,
        AppStrings.phoneNumberField: phoneNumber,
        AppStrings.emailField: email,
        AppStrings.photoUrlField: photoUrls,
        AppStrings.followersField: followers,
        AppStrings.followingsField: followings,
        AppStrings.postsField: posts,
        AppStrings.bookmarkedField: bookmarked,
      };

  factory UserModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();

    return UserModel(
      uid: data![AppStrings.uidField],
      userName: data[AppStrings.userNameField],
      email: data[AppStrings.emailField],
      bio: data[AppStrings.bioField],
      followers: data[AppStrings.followersField],
      followings: data[AppStrings.followingsField],
      posts: data[AppStrings.postsField],
      bookmarked: data[AppStrings.bookmarkedField],
      photoUrls: data[AppStrings.photoUrlField],
      authProvider: data[AppStrings.authProviderField],
      name: data[AppStrings.nameField],
      phoneNumber: data[AppStrings.phoneNumberField],
      gender: data[AppStrings.genderField],
    );
  }
}
