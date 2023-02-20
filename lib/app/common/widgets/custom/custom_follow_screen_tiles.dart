import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/modules/follow/controllers/follow_controller.dart';

class CustomFollowScreenTile extends StatelessWidget {
  final FollowController _followController = Get.put(FollowController());

  final String tileTitle;
  final String route;

  CustomFollowScreenTile({
    required this.tileTitle,
    required this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Stack(
                      children: const [
                        Positioned(
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                          ),
                        ),
                        Positioned(
                          left: 15,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                          ),
                        ),
                        Positioned(
                          left: 30,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    tileTitle,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (tileTitle == "Following") {
                    _followController.getAllFollowingUserDetails();
                  } else if (tileTitle == "Followers") {
                    _followController.getAllFollowersUserDetails();
                  }

                  Get.toNamed(route);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.3),
                  radius: 15,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
