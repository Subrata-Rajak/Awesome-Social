import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/utils/image_paths.dart';

import '../../../common/utils/strings.dart';
import '../../../common/widgets/custom/custom_text_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Obx(
      () {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      10,
                      0,
                      0,
                    ),
                    child: Text(
                      AppStrings.appName,
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontFamily: 'Montserrat Alternates',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      controller.image.value.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(
                                controller.image.value,
                              ),
                              radius: 64,
                            )
                          : const CircleAvatar(
                              backgroundImage: AssetImage(
                                ImagePaths.userProfileDefault,
                              ),
                              radius: 64,
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () {
                            controller.selectImage();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                          ),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      40,
                      40,
                      40,
                      0,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: controller,
                            hintText: AppStrings.userNameHintText,
                            labelText: AppStrings.userNameLabel,
                            prefixIcon: Icons.account_circle_outlined,
                            textEditingController:
                                controller.userNameTextController,
                            isFocused: controller.isUserNameFocused,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: controller,
                            hintText: AppStrings.emailHintText,
                            labelText: AppStrings.emailLabel,
                            prefixIcon: Icons.email_outlined,
                            textEditingController:
                                controller.emailTextController,
                            isFocused: controller.isEmailFocused,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: controller,
                            hintText: AppStrings.passwordHintText,
                            labelText: AppStrings.passwordLabel,
                            prefixIcon: Icons.lock_outline_rounded,
                            textEditingController:
                                controller.passwordTextController,
                            isFocused: controller.isPasswordFocused,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: controller,
                            hintText: AppStrings.confirmPasswordHintText,
                            labelText: AppStrings.confirmPasswordLabel,
                            prefixIcon: Icons.lock_outline_rounded,
                            textEditingController:
                                controller.confirmPasswordTextController,
                            isFocused: controller.isConfirmPasswordFocused,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      10,
                      40,
                      0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String res = controller.registerCall(
                              email: controller.emailTextController.text,
                              password: controller.passwordTextController.text,
                              confirmPassword: controller.confirmPasswordTextController.text,
                              userName: controller.userNameTextController.text,
                              file: controller.image.value,
                            );

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
                                  res,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                // action: SnackBarAction(
                                //   label: 'Ok',
                                //   textColor: Colors.white,
                                //   onPressed: () {
                                //     ScaffoldMessenger.of(context)
                                //         .hideCurrentSnackBar();
                                //   },
                                // ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(
                              20,
                              10,
                              20,
                              10,
                            ),
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                          child: const Text(
                            AppStrings.signUpButtonText,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.fromLTRB(
                  //     0,
                  //     10,
                  //     0,
                  //     0,
                  //   ),
                  //   child: Text(
                  //     "Or",
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //       color: Colors.white,
                  //       fontFamily: 'Lobster',
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(
                  //     40,
                  //     10,
                  //     40,
                  //     0,
                  //   ),
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.all(
                  //         20,
                  //       ),
                  //       backgroundColor: Colors.black,
                  //       shape: const RoundedRectangleBorder(
                  //         side: BorderSide(
                  //           color: Colors.blue,
                  //           width: 2,
                  //         ),
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(
                  //             10,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Row(
                  //           children: const [
                  //             Image(
                  //               image: AssetImage(
                  //                 "assets/images/google_logo.png",
                  //               ),
                  //               width: 20,
                  //               height: 20,
                  //             ),
                  //             SizedBox(
                  //               width: 20,
                  //             ),
                  //             Text(
                  //               "Sign in with Google",
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      10,
                      0,
                      0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          child: const Text(
                            AppStrings.loginButtonText,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
