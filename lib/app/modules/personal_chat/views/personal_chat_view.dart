import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:insta_clone/app/common/controllers/firebase/firestore_controller.dart';
import 'package:insta_clone/app/common/utils/strings.dart';
import 'package:insta_clone/app/common/widgets/list%20items/message_list_item.dart';
import 'package:insta_clone/app/data/arguments/personal_chat_view_arguments.dart';
import 'package:insta_clone/app/modules/personal_chat/controllers/personal_chat_controller.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../others_profile/controllers/others_profile_controller.dart';

class PersonalChatView extends GetView<PersonalChatController> {
  final PersonalChatController _controller = Get.put(PersonalChatController());
  PersonalChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PersonalChatViewArguments;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () async {
                Get.toNamed(Routes.OTHERS_PROFILE);
                await OthersProfileController.instance
                    .getUserDetails(args.firstPersonUid);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  args.senderImagePath,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args.userName,
                ),
                Text(
                  args.name,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                10,
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(AppStrings.messagesCollection)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection(args.firstPersonUid)
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
                      return MessageListItem(
                          senderImagePath: args.senderImagePath,
                          message: snapshot.data!.docs[index]
                              [AppStrings.messageField],
                          senderId: snapshot.data!.docs[index]
                              [AppStrings.senderUidField],
                          datePublished: "${DateFormat("MMM d").format(
                            snapshot.data!
                                .docs[index][AppStrings.datePublishedField]
                                .toDate(),
                          )} ${DateFormat.jm().format(
                            snapshot.data!
                                .docs[index][AppStrings.datePublishedField]
                                .toDate(),
                          )}");
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 30,
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      80,
                    ),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      80,
                    ),
                  ),
                ),
                hintText: "Message...",
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera,
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    final message = controller.messageController.text;
                    controller.messageController.clear();

                    await FireStoreController.instance.storeMessages(
                      currentUserUid: FirebaseAuth.instance.currentUser!.uid,
                      firstPersonUid: args.firstPersonUid,
                      senderUid: FirebaseAuth.instance.currentUser!.uid,
                      receiverUid: args.firstPersonUid,
                      message: message,
                      datePublished: DateTime.now(),
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.blue,
                  ),
                ),
                fillColor: Colors.grey.withOpacity(0.3),
              ),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
