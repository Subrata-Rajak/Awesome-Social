import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final GetxController controller;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final TextEditingController textEditingController;
  final RxBool isFocused;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.textEditingController,
    required this.isFocused,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return FocusScope(
          child: Focus(
            onFocusChange: (focus) {
              isFocused.value = focus;
            },
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color:
                      isFocused.value ? Colors.blue : Colors.white,
                ),
                prefixIcon: Icon(
                  prefixIcon,
                  color:
                      isFocused.value ? Colors.blue : Colors.white,
                ),
                label: Text(
                  labelText,
                  style: TextStyle(
                    color:
                        isFocused.value ? Colors.blue : Colors.white,
                  ),
                ),
                fillColor: Colors.white,
              ),
              style: TextStyle(
                color: isFocused.value ? Colors.blue : Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
