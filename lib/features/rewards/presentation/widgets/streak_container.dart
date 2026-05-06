import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class StreakContainer extends StatelessWidget {
  const StreakContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColorsLight.secondary.withAlpha(40),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('🔥', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '12-day streak',
                      style: AppTextStyles.body.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      'Keep going to unlock the consistent badge!',
                      style: AppTextStyles.body,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
