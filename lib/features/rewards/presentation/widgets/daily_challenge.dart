import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/features/rewards/domain/models/daily_challenge_model.dart';

class DailyChallenge extends StatelessWidget {
  final DailyChallengeModel dailyChallenge;

  const DailyChallenge({super.key, required this.dailyChallenge});

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
              Text(dailyChallenge.description, style: AppTextStyles.body),
              Text(
                '+${dailyChallenge.rewardPoints} pts',
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
              value: dailyChallenge.completed ? 1.0 : 0.5,
              backgroundColor: Theme.of(context).focusColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColorsLight.secondary,
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            dailyChallenge.completed ? '✓ Completed!' : 'In Progress',
            style: AppTextStyles.bodySmall.copyWith(
              color: dailyChallenge.completed
                  ? AppColorsLight.primary
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
