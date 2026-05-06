import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/features/child/presentation/providers/child_provider.dart';
import 'package:marco/features/rewards/presentation/widgets/badges.dart';
import 'package:marco/features/rewards/presentation/widgets/daily_challenge.dart';
import 'package:marco/features/rewards/presentation/widgets/streak_container.dart';
import 'package:marco/features/rewards/presentation/widgets/total_points.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childState = ref.watch(childProvider);

    return Scaffold(
      appBar: childState.isLoading
          ? null
          : AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${childState.child?.name}\'s achievements',
                    style: AppTextStyles.title,
                  ),
                  Row(
                    children: [
                      // Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('🌱', style: TextStyle(fontSize: 12)),
                      SizedBox(width: 4),
                      Text('Eco Explorer - Level 4', style: AppTextStyles.body),
                    ],
                  ),
                ],
              ),
            ),
      body: childState.isLoading
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TotalPoints(),
                  const SizedBox(height: 16),
                  const StreakContainer(),
                  const SizedBox(height: 16),
                  const Text('Your Badges', style: AppTextStyles.headline2),
                  const SizedBox(height: 8),
                  const Badges(),
                  const SizedBox(height: 16),
                  const Text('Daily Challenge', style: AppTextStyles.headline2),
                  const SizedBox(height: 8),
                  const DailyChallenge(),
                ],
              ),
            ),
    );
  }
}
