import 'package:flutter/material.dart';

class CustomFollowButton extends StatelessWidget {
  final void Function()? func;

  const CustomFollowButton({
    required this.func,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
      ),
      child: const Text(
        "Follow",
      ),
    );
  }
}
