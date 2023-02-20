import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/controllers/firebase/firestore_controller.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/data/firebase/user_model.dart';

class FollowController extends GetxController {
  static FollowController get instance => Get.put(FollowController());

  var allUserData = List<UserModel>.empty().obs;
  var allFollowingsData = List<UserModel>.empty().obs;
  var allFollowersData = List<UserModel>.empty().obs;
  var isLoading = false.obs;
  var isFirstTime = true;

  var currentUserData = {};
  var anotherUserData = {};

  Future<void> getCurrentUserDetails() async {
    var snap = await FireStoreController.instance
        .getUserData(FirebaseAuth.instance.currentUser!.uid);

    currentUserData = snap.data()!;
  }

  Future<void> getAnotherUserData(String uid) async {
    var snap = await FireStoreController.instance.getUserData(uid);

    anotherUserData = snap.data()!;
  }

  void updateFollowingsList(String followingUid) async {
    await getCurrentUserDetails();

    await FireStoreController.instance.updateFollowingList(
      currentUserData[AppStrings.followingsField],
      followingUid,
    );

    await getAnotherUserData(followingUid);

    await FireStoreController.instance.updateFollowersList(
      anotherUserData[AppStrings.followersField],
      followingUid,
    );
  }

  void getAllUserDetails() async {
    isLoading.value = true;
    allUserData.value = await FireStoreController.instance.getAllUserData();

    for (var i = 0; i < allUserData.length; i++) {
      if (allUserData[i].uid == FirebaseAuth.instance.currentUser!.uid) {
        allUserData.remove(allUserData[i]);
      }
    }

    await getCurrentUserDetails();

    for (var i = 0;
        i < currentUserData[AppStrings.followingsField].length;
        i++) {
      for (var j = 0; j < allUserData.length; j++) {
        if (currentUserData[AppStrings.followingsField][i] ==
            allUserData[j].uid) {
          allUserData.remove(allUserData[j]);
        }
      }
    }
    isFirstTime = false;
    isLoading.value = false;
  }

  void getAllFollowersUserDetails() async {
    isLoading.value = true;
    await getCurrentUserDetails();

    for (var i = 0;
        i < currentUserData[AppStrings.followersField].length;
        i++) {
      var snap = await FireStoreController.instance
          .getUserData(currentUserData[AppStrings.followersField][i]);

      var currentFollowerData = snap.data()!;

      UserModel currentFollower = UserModel(
        uid: currentFollowerData[AppStrings.uidField],
        userName: currentFollowerData[AppStrings.userNameField],
        email: currentFollowerData[AppStrings.emailField],
        bio: currentFollowerData[AppStrings.bioField],
        followers: currentFollowerData[AppStrings.followersField],
        followings: currentFollowerData[AppStrings.followingsField],
        posts: currentFollowerData[AppStrings.postsField],
        bookmarked: currentFollowerData[AppStrings.bookmarkedField],
        photoUrls: currentFollowerData[AppStrings.photoUrlField],
        authProvider: currentFollowerData[AppStrings.authProviderField],
        name: currentFollowerData[AppStrings.nameField],
        phoneNumber: currentFollowerData[AppStrings.phoneNumberField],
        gender: currentFollowerData[AppStrings.genderField],
      );

      allFollowersData.add(currentFollower);
    }
    isLoading.value = false;
  }

  void getAllFollowingUserDetails() async {
    isLoading.value = true;
    await getCurrentUserDetails();

    for (var i = 0;
        i < currentUserData[AppStrings.followingsField].length;
        i++) {
      var snap = await FireStoreController.instance
          .getUserData(currentUserData[AppStrings.followingsField][i]);

      var currentFollowingData = snap.data()!;

      UserModel currentFollowing = UserModel(
        uid: currentFollowingData[AppStrings.uidField],
        userName: currentFollowingData[AppStrings.userNameField],
        email: currentFollowingData[AppStrings.emailField],
        bio: currentFollowingData[AppStrings.bioField],
        followers: currentFollowingData[AppStrings.followersField],
        followings: currentFollowingData[AppStrings.followingsField],
        posts: currentFollowingData[AppStrings.postsField],
        bookmarked: currentFollowingData[AppStrings.bookmarkedField],
        photoUrls: currentFollowingData[AppStrings.photoUrlField],
        authProvider: currentFollowingData[AppStrings.authProviderField],
        name: currentFollowingData[AppStrings.nameField],
        phoneNumber: currentFollowingData[AppStrings.phoneNumberField],
        gender: currentFollowingData[AppStrings.genderField],
      );

      allFollowingsData.add(currentFollowing);
    }
    isLoading.value = false;
  }

  bool followingChecker(String uid) {
    var res = false;

    for (var i = 0;
        i < currentUserData[AppStrings.followingsField].length;
        i++) {
      if (currentUserData[AppStrings.followingsField][i] == uid) {
        res = true;
      }
    }

    return res;
  }

  Future<void> unFollow(String uid) async {
    isLoading.value = true;

    await getCurrentUserDetails();
    await getAnotherUserData(uid);

    for (var i = 0;
        i < currentUserData[AppStrings.followingsField].length;
        i++) {
      if (currentUserData[AppStrings.followingsField][i] == uid) {
        currentUserData[AppStrings.followingsField]
            .remove(currentUserData[AppStrings.followingsField][i]);
      }
    }

    for (var i = 0;
        i < anotherUserData[AppStrings.followersField].length;
        i++) {
      if (anotherUserData[AppStrings.followersField][i] ==
          FirebaseAuth.instance.currentUser!.uid) {
        anotherUserData[AppStrings.followersField]
            .remove(anotherUserData[AppStrings.followersField][i]);
      }
    }

    await FireStoreController.instance.unFollowUser(
      currentUserData[AppStrings.followingsField],
      anotherUserData[AppStrings.followersField],
      uid,
    );

    isLoading.value = false;
  }
}
