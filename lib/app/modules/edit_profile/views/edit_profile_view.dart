import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/modules/profile/controllers/profile_controller.dart';

import '../../../common/widgets/custom/custom_edit_profile_text_field.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.nameTextEditingController.text =
        ProfileController.instance.userData[AppStrings.nameField];
    controller.userNameTextEditingController.text =
        ProfileController.instance.userData[AppStrings.userNameField];
    controller.bioTextEditingController.text =
        ProfileController.instance.userData[AppStrings.bioField];
    controller.emailTextEditingController.text =
        ProfileController.instance.userData[AppStrings.emailField];
    controller.phoneTextEditingController.text =
        ProfileController.instance.userData[AppStrings.phoneNumberField];
    controller.genderTextEditingController.text =
        ProfileController.instance.userData[AppStrings.genderField];

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
              AppStrings.editProfileBarTitle,
            ),
            leading: IconButton(
              onPressed: () {
                // if (controller.isStatusChanged()) {
                //   showDialog<String>(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: const Text('Wanna Save?'),
                //         content: const Text(
                //           'You have unsaved changes, do you want to save them?',
                //         ),
                //         actions: <Widget>[
                //           TextButton(
                //             onPressed: () {
                //               Navigator.pop(context, 'Cancel');
                //               Get.back();
                //             },
                //             child: const Text('Discard'),
                //           ),
                //           TextButton(
                //             onPressed: () {
                //               Navigator.pop(context, 'OK');
                //             },
                //             child: const Text('Ok'),
                //           ),
                //         ],
                //       );
                //     },
                //   );
                // } else {}
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  controller.logoutUser();
                },
                icon: const Icon(
                  Icons.logout_outlined,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.newProfPic.value.isEmpty
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                ProfileController.instance
                                        .userData[AppStrings.photoUrlField][
                                    ProfileController
                                            .instance
                                            .userData[AppStrings.photoUrlField]
                                            .length -
                                        1],
                              ),
                              radius: 40,
                            )
                          : CircleAvatar(
                              backgroundImage: MemoryImage(
                                controller.newProfPic.value,
                              ),
                              radius: 40,
                            ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              ProfileController
                                  .instance.userData[AppStrings.userNameField],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.selectImage();
                            },
                            child: const Text(
                              "Change Profile Photo",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CustomEditProfileTextField(
                  labelText: "Name",
                  description: AppStrings.editProfileNameText,
                  controller: controller.nameTextEditingController,
                  top: 20,
                ),
                CustomEditProfileTextField(
                  labelText: "User Name",
                  description: AppStrings.editProfileUserNameText,
                  controller: controller.userNameTextEditingController,
                  top: 40,
                ),
                CustomEditProfileTextField(
                  labelText: "Bio",
                  description: null,
                  controller: controller.bioTextEditingController,
                  top: 40,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    60,
                    20,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        AppStrings.editProfilePIDescriptionText,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomEditProfileTextField(
                  labelText: "Email",
                  description: null,
                  controller: controller.emailTextEditingController,
                  top: 20,
                  enabled: false,
                ),
                CustomEditProfileTextField(
                  labelText: "Phone Number",
                  description: null,
                  controller: controller.phoneTextEditingController,
                  top: 20,
                ),
                CustomEditProfileTextField(
                  labelText: "Gender",
                  description: null,
                  controller: controller.genderTextEditingController,
                  top: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    30,
                    0,
                    20,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () async {
                      String res = await controller.updateUserDetails();

                      if (res == "Success") {
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
                            content: const Text(
                              "Profile Updated!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            action: SnackBarAction(
                              label: 'Ok',
                              textColor: Colors.white,
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      AppStrings.submitText,
                      style: TextStyle(
                        fontSize: 25,
                      ),
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
