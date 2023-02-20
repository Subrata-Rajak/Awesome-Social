import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/modules/post/controllers/customize_post_controller.dart';

import '../../../common/utils/strings.dart';

class CustomizePostView extends GetView<CustomizePostController> {
  const CustomizePostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            bottom: !controller.isLoading.value
                ? PreferredSize(
                    preferredSize: const Size(0, 0),
                    child: Container(
                      height: 0.2,
                      color: Colors.white,
                    ),
                  )
                : const PreferredSize(
                    preferredSize: Size(
                      0,
                      0,
                    ),
                    child: LinearProgressIndicator(),
                  ),
            title: const Text(
              AppStrings.customizePostBarTitle,
            ),
            leading: IconButton(
              onPressed: () {
                controller.descriptionController.clear();
                controller.image.value = Uint8List(0);
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await controller.storePost();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      margin: const EdgeInsets.fromLTRB(
                        40,
                        0,
                        40,
                        50,
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.blue,
                      content: Text(
                        controller.res,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      action: SnackBarAction(
                        label: 'Ok',
                        textColor: Colors.white,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );

                  if (controller.res == "Posted!") {
                    controller.descriptionController.clear();
                    controller.image.value = Uint8List(0);
                  }
                },
                child: const Text(
                  "Post",
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    0,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.currentUserData[AppStrings.photoUrlField][
                              controller
                                      .currentUserData[AppStrings.photoUrlField]
                                      .length -
                                  1],
                        ),
                        radius: 40,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.currentUserData[AppStrings.nameField],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller
                                .currentUserData[AppStrings.userNameField],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    0,
                  ),
                  child: TextField(
                    controller: controller.descriptionController,
                    decoration: InputDecoration(
                      hintText: "Enter your caption",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(
                          0.3,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(
                        0.1,
                      ),
                    ),
                    maxLines: 8,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    60,
                    20,
                    10,
                  ),
                  child: controller.image.value.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white.withOpacity(0.3),
                                size: 100,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.selectImage();
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10)),
                                child: const Text(
                                  "Pick an Image",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Image(
                          image: MemoryImage(
                            controller.image.value,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
