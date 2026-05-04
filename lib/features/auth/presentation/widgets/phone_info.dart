import 'package:flutter/material.dart';

class PhoneInfo extends StatelessWidget {
  const PhoneInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Your phone is your primary identifier. SMS alerts about your child\'s route status will be sent here.',
            ),
          ),
        ],
      ),
    );
  }
}
