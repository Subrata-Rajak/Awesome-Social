import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final RxBool isShowUser;
  
  const CustomSearchTextField({
    required this.controller,
    required this.isShowUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        hintText: "Joe",
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.white,
        ),
        suffixIcon: isShowUser.value
            ? IconButton(
                onPressed: () {
                  controller.clear();
                  isShowUser.value = false;
                },
                icon: const Icon(
                  Icons.clear_sharp,
                ),
              )
            : IconButton(
                onPressed: () {
                  isShowUser.value = true;
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
        label: const Text(
          "Search for a user",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        fillColor: Colors.grey.withOpacity(0.3),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
