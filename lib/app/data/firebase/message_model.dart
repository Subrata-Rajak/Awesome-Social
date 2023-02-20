import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/app/common/utils/strings.dart';

class MessageModel {
  final String senderUid;
  final String receiverUid;
  final String message;
  final int messageNumber;
  final datePublished;

  MessageModel({
    required this.senderUid,
    required this.receiverUid,
    required this.message,
    required this.datePublished,
    required this.messageNumber,
  });

  Map<String, dynamic> toJson() => {
        AppStrings.senderUidField: senderUid,
        AppStrings.receiverUidField: receiverUid,
        AppStrings.messageField: message,
        AppStrings.datePublishedField: datePublished,
        AppStrings.messageNumberField: messageNumber,
      };

  factory MessageModel.fromSnapShot(
    DocumentSnapshot<Map<String, dynamic>> snap,
  ) {
    final data = snap.data()!;

    return MessageModel(
      senderUid: data[AppStrings.senderUidField],
      receiverUid: data[AppStrings.receiverUidField],
      message: data[AppStrings.messageField],
      datePublished: data[AppStrings.datePublishedField],
      messageNumber: data[AppStrings.messageNumberField],
    );
  }
}
