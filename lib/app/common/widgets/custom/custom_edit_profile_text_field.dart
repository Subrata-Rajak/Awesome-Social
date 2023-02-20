import 'package:flutter/material.dart';

class CustomEditProfileTextField extends StatelessWidget {
  final String labelText;
  final String? description;
  final TextEditingController controller;
  final double top;
  final bool enabled;

  const CustomEditProfileTextField({
    required this.labelText,
    required this.description,
    required this.controller,
    required this.top,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        top,
        20,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                labelText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            enabled: enabled,
            controller: controller,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          description == null
              ? const SizedBox(
                  width: 0,
                  height: 0,
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      description!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(
                          0.4,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
