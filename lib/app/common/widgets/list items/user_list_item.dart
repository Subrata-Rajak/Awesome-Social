import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/widgets/custom/custom_follow_button.dart';
import 'package:insta_clone/app/modules/follow/controllers/follow_controller.dart';
import 'package:insta_clone/app/modules/others_profile/controllers/others_profile_controller.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import '../../../data/firebase/user_model.dart';
import '../../utils/strings.dart';

class UserListItem extends StatelessWidget {
  final FollowController _followController = Get.put(FollowController());

  final UserModel user;

  UserListItem({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  Get.toNamed(Routes.OTHERS_PROFILE);
                  await OthersProfileController.instance
                      .getUserDetails(user.uid);
                },
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(AppStrings.userCollection)
                      .doc(user.uid)
                      .snapshots(),
                  builder: (
                    context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircleAvatar(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return CircleAvatar(
                      backgroundImage: NetworkImage(
                        snapshot.data![AppStrings.photoUrlField][
                            snapshot.data![AppStrings.photoUrlField].length -
                                1],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName,
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      user.bio,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          CustomFollowButton(
            func: () {
              showDialog<String>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Wanna Follow?'),
                    content:
                        Text('Do you really want to follow ${user.userName}'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _followController.updateFollowingsList(user.uid);
                          _followController.getAllUserDetails();
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
