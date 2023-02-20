import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final String imagePath;
  final String userName;

  const ChatListItem({
    required this.imagePath,
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 66,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    imagePath,
                  ),
                  radius: 25,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
