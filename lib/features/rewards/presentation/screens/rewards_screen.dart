import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rewards', style: AppTextStyles.title)),
      body: const Center(child: Text('Your rewards will appear here!')),
    );
  }
}
