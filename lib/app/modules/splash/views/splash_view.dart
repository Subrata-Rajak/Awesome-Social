import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/get%20storage/local_storage_repo.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      LocalStorageRepo.instance
              .readData(key: AppStrings.getStorageIsLoggedInKey)
          ? Get.offAllNamed(Routes.HOME)
          : Get.offAllNamed(Routes.LOGIN);
    });
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/app_logo.png",
                    ),
                    radius: 40,
                  ),
                  Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: <Color>[
                            Colors.purple,
                            Colors.red,
                            Colors.yellow,
                          ],
                        ).createShader(
                          const Rect.fromLTWH(
                            10,
                            0,
                            300.0,
                            300.0,
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Text(
              "Made\nby\nSubrata Rajak",
              textAlign: TextAlign.center,
              style: TextStyle(
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: <Color>[
                      Colors.purple,
                      Colors.red,
                      Colors.yellow,
                    ],
                  ).createShader(
                    const Rect.fromLTWH(
                      10,
                      0,
                      300.0,
                      300.0,
                    ),
                  ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
