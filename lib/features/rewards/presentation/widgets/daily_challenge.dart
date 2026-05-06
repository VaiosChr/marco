import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class DailyChallenge extends StatelessWidget {
  const DailyChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Try MARCO\'s suggestion', style: AppTextStyles.body),
              Text(
                '+50 pts',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColorsLight.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 1,
              backgroundColor: Theme.of(context).focusColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColorsLight.secondary,
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '✓ Completed!',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColorsLight.primary,
            ),
          ),
        ],
      ),
    );
  }
}
