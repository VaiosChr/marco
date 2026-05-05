import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class TripLogScreen extends StatelessWidget {
  const TripLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip Log', style: AppTextStyles.title)),
      body: const Center(child: Text('Your trip logs will appear here!')),
    );
  }
}
