import 'package:flutter/material.dart';

class CustomFollowingButton extends StatelessWidget {
  final void Function()? func;

  const CustomFollowingButton({
    required this.func,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              5,
            ),
          ),
          side: BorderSide(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      child: const Text(
        "Following",
      ),
    );
  }
}
