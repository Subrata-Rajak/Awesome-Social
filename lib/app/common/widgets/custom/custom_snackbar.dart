import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String contentText;
  const CustomSnackbar({
    required this.contentText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      padding: const EdgeInsets.all(
        40,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue,
      content: Text(
        contentText,
      ),
    );
  }
}
