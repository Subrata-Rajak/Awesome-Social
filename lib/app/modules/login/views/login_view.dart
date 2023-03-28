import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/utils/strings.dart';
import '../../../common/widgets/custom/custom_text_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  100,
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
                        hintText: AppStrings.emailHintText,
                        labelText: AppStrings.emailLabel,
                        prefixIcon: Icons.email_outlined,
                        textEditingController: controller.emailTextController,
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  40,
                  10,
                  0,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.FORGOT_PASSWORD);
                      },
                      child: const Text(
                        AppStrings.forgotPasswordButtonText,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  0,
                  0,
                  40,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String res = controller.loginCall(
                          email: controller.emailTextController.text,
                          password: controller.passwordTextController.text,
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
                        AppStrings.loginButtonText,
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
                        Get.offAllNamed(Routes.SIGN_UP);
                      },
                      child: const Text(
                        AppStrings.signUpButtonText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
