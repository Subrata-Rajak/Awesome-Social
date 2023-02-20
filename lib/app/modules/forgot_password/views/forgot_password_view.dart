import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/utils/strings.dart';
import '../../../common/widgets/custom/custom_text_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/forgot_password_bg.png",
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    AppStrings.forgotPasswordButtonText,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    40,
                    30,
                    40,
                    0,
                  ),
                  child: Center(
                    child: CustomTextField(
                      controller: controller,
                      hintText: AppStrings.emailHintText,
                      isFocused: controller.isEmailFocused,
                      labelText: AppStrings.emailLabel,
                      prefixIcon: Icons.email,
                      textEditingController: controller.emailTextController,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  0,
                  30,
                  40,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
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
                        AppStrings.submitText,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                      "Done with Forgot Password?",
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
  }
}

