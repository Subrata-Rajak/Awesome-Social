import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/widgets/custom/custom_profile_stats_columns.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import '../../../common/utils/strings.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final ProfileController _controller = Get.put(ProfileController());

  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _controller.getUserDetails(isSubmitButtonClicked: false);
    return Obx(
      () {
        return controller.isLoading.value
            ? Scaffold(
                appBar: AppBar(
                  title: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(AppStrings.profileBarTitle),
                  ),
                  backgroundColor: Colors.black,
                ),
                body: const Center(child: CircularProgressIndicator()),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      controller.userData[AppStrings.userNameField],
                    ),
                  ),
                  backgroundColor: Colors.black,
                ),
                body: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 130,
                      padding: const EdgeInsets.fromLTRB(
                        10,
                        10,
                        20,
                        0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  radius: 50,
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
                                radius: 50,
                              );
                            },
                          ),
                          SizedBox(
                            width: 200,
                            height: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomProfileStatsColumn(
                                      statNumbers: controller
                                          .userData[AppStrings.postsField]
                                          .length
                                          .toString(),
                                      statText: "Posts",
                                    ),
                                    CustomProfileStatsColumn(
                                      statNumbers: controller
                                          .userData[AppStrings.followersField]
                                          .length
                                          .toString(),
                                      statText: "Followers",
                                    ),
                                    CustomProfileStatsColumn(
                                      statNumbers: controller
                                          .userData[AppStrings.followingsField]
                                          .length
                                          .toString(),
                                      statText: "Followings",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.toNamed(Routes.EDIT_PROFILE);
                                    },
                                    child: const Text(
                                      AppStrings.editProfileButtonText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        0,
                        20,
                        0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                return const Text(
                                  "",
                                );
                              }
                              return Text(
                                snapshot.data![AppStrings.userNameField],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                return const Text(
                                  "",
                                );
                              }
                              return Text(
                                snapshot.data![AppStrings.bioField],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: BottomBarDivider(
                        color: Colors.white,
                        colorSelected: Colors.white,
                        backgroundColor: Colors.black,
                        iconSize: 30,
                        animated: true,
                        items: _controller.tabs,
                        onTap: (index) async {
                          _controller.selectedIndex.value = index;
                        },
                        indexSelected: _controller.selectedIndex.value,
                        styleDivider: StyleDivider.bottom,
                      ),
                    ),
                    Expanded(
                      child: _controller.views[_controller.selectedIndex.value],
                    )
                  ],
                ),
              );
      },
    );
  }
}
