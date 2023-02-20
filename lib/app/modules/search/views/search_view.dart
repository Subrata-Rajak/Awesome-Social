import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/widgets/custom/custom_search_text_field.dart';

import '../../../common/utils/strings.dart';
import '../../../routes/app_pages.dart';
import '../../others_profile/controllers/others_profile_controller.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  final SearchController _controller = Get.put(SearchController());

  SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SafeArea(
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                10,
                10,
                10,
                0,
              ),
              child: Column(
                children: [
                  CustomSearchTextField(
                    controller: controller.searchController,
                    isShowUser: controller.isShowUser,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  controller.isShowUser.value
                      ? FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection(AppStrings.userCollection)
                              .where(
                                AppStrings.userNameField,
                                isGreaterThanOrEqualTo:
                                    controller.searchController.value.text,
                              )
                              .get(),
                          builder: (context, snapShot) {
                            if (snapShot.connectionState ==
                                ConnectionState.waiting) {
                              return const Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            return Expanded(
                              child: ListView.separated(
                                itemCount:
                                    (snapShot.data! as dynamic).docs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      Get.toNamed(Routes.OTHERS_PROFILE);
                                      await OthersProfileController.instance
                                          .getUserDetails(
                                              (snapShot.data! as dynamic)
                                                      .docs[index]
                                                  [AppStrings.uidField]);
                                    },
                                    child: ListTile(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      tileColor: Colors.white.withOpacity(
                                        0.12,
                                      ),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          (snapShot.data! as dynamic)
                                                      .docs[index]
                                                  [AppStrings.photoUrlField][
                                              (snapShot.data! as dynamic)
                                                      .docs[index][AppStrings
                                                          .photoUrlField]
                                                      .length -
                                                  1],
                                        ),
                                      ),
                                      title: Text(
                                        (snapShot.data! as dynamic).docs[index]
                                            [AppStrings.userNameField],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: ((context, index) {
                                  return const SizedBox(
                                    height: 5,
                                  );
                                }),
                              ),
                            );
                          },
                        )
                      : FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection(AppStrings.postsCollection)
                              .get(),
                          builder: (context, snapShot) {
                            if (snapShot.connectionState ==
                                ConnectionState.waiting) {
                              return const Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            return Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount:
                                    (snapShot.data! as dynamic).docs.length,
                                itemBuilder: (context, index) {
                                  return Image(
                                    image: NetworkImage(
                                      (snapShot.data! as dynamic).docs[index]
                                          [AppStrings.postPhotoUrlField],
                                    ),
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
