import 'package:flutter/material.dart';

class CustomProfileStatsColumn extends StatelessWidget {
  final String statNumbers;
  final String statText;

  const CustomProfileStatsColumn({
    required this.statNumbers,
    required this.statText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          statNumbers,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          statText,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
