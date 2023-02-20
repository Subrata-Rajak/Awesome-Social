import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageListItem extends StatelessWidget {
  final String senderImagePath;
  final String message;
  final String senderId;
  final String datePublished;

  const MessageListItem({
    required this.senderImagePath,
    required this.message,
    required this.senderId,
    required this.datePublished,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: senderId != FirebaseAuth.instance.currentUser!.uid
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        senderId != FirebaseAuth.instance.currentUser!.uid
            ? SenderMessageTile(
                imagePath: senderImagePath,
                message: message,
                datePublished: datePublished,
              )
            : ReceiverMessageTile(
                message: message,
                datePublished: datePublished,
              ),
      ],
    );
  }
}

class SenderMessageTile extends StatelessWidget {
  const SenderMessageTile({
    super.key,
    required this.imagePath,
    required this.message,
    required this.datePublished,
  });

  final String imagePath;
  final String message;
  final String datePublished;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            imagePath,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(
                15,
              ),
              child: Wrap(
                children: [
                  Text(
                    message,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              datePublished,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ReceiverMessageTile extends StatelessWidget {
  const ReceiverMessageTile({
    super.key,
    required this.message,
    required this.datePublished,
  });

  final String message;
  final String datePublished;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(
                  0.3,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(
                15,
              ),
              child: Wrap(
                children: [
                  Text(
                    message,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              datePublished,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
