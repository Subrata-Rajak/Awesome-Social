import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:insta_clone/app/common/widgets/custom/custom_search_text_field.dart';
import 'package:insta_clone/app/common/widgets/list%20items/chat_list_item.dart';
import 'package:insta_clone/app/data/arguments/personal_chat_view_arguments.dart';
import 'package:insta_clone/app/modules/personal_chat/bindings/personal_chat_binding.dart';
import 'package:insta_clone/app/routes/app_pages.dart';

import '../../../common/utils/strings.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(AppStrings.userCollection)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(AppStrings.chatBarTitle);
            }

            return Text(snapshot.data![AppStrings.userNameField]);
          },
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_outlined,
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchTextField(
                controller: controller.searchController,
                isShowUser: controller.isShowUser,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(
                10,
                10,
                0,
                0,
              ),
              child: Text(
                "Messages",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  10,
                  10,
                  5,
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(AppStrings.userCollection)
                      .where(
                        AppStrings.uidField,
                        isNotEqualTo: FirebaseAuth.instance.currentUser!.uid,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.PERSONAL_CHAT,
                              arguments: PersonalChatViewArguments(
                                senderImagePath: snapshot.data!.docs[index]
                                    [AppStrings.photoUrlField][snapshot
                                        .data!
                                        .docs[index][AppStrings.photoUrlField]
                                        .length -
                                    1],
                                userName: snapshot.data!.docs[index]
                                    [AppStrings.userNameField],
                                name: snapshot.data!.docs[index]
                                    [AppStrings.nameField],
                                firstPersonUid: snapshot.data!.docs[index]
                                    [AppStrings.uidField],
                              ),
                            );
                          },
                          child: ChatListItem(
                            imagePath: snapshot.data!.docs[index]
                                [AppStrings.photoUrlField][snapshot
                                    .data!
                                    .docs[index][AppStrings.photoUrlField]
                                    .length -
                                1],
                            userName: snapshot.data!.docs[index]
                                [AppStrings.userNameField],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
