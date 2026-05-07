import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/core/services/mock_api_service.dart';
import 'package:marco/features/child/presentation/providers/child_provider.dart';
import 'package:marco/features/rewards/data/rewards_repository.dart';
import 'package:marco/features/rewards/domain/models/rewards_model.dart';
import 'package:marco/features/rewards/presentation/widgets/badges.dart';
import 'package:marco/features/rewards/presentation/widgets/daily_challenge.dart';
import 'package:marco/features/rewards/presentation/widgets/streak_container.dart';
import 'package:marco/features/rewards/presentation/widgets/total_points.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  Future<RewardsModel> _fetchRewards(WidgetRef ref) async {
    final repo = RewardsRepository(ref.read(mockApiServiceProvider));
    final data = await repo.getRewards();

    if (data is Map<String, dynamic>) {
      return RewardsModel.fromJson(data);
    }

    if (data is List && data.isNotEmpty && data.first is Map) {
      return RewardsModel.fromJson(
        Map<String, dynamic>.from(data.first as Map),
      );
    }

    throw const FormatException('Unexpected rewards response shape.');
  }

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
                  Text('🌱 Eco Explorer - Level 4', style: AppTextStyles.body),
                ],
              ),
            ),
      body: FutureBuilder<RewardsModel>(
        future: _fetchRewards(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Text('No data available');
          }

          final rewards = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TotalPoints(
                  points: rewards.totalPoints,
                  nextLevelPoints: rewards.nextLevelPoints,
                ),
                const SizedBox(height: 16),
                StreakContainer(streakDays: rewards.streakDays),
                const SizedBox(height: 16),
                const Text('Your Badges', style: AppTextStyles.headline2),
                const SizedBox(height: 8),
                Badges(badges: rewards.badges),
                const SizedBox(height: 16),
                const Text('Daily Challenge', style: AppTextStyles.headline2),
                const SizedBox(height: 8),
                if (rewards.dailyChallenge != null)
                  DailyChallenge(dailyChallenge: rewards.dailyChallenge!),
              ],
            ),
          );
        },
      ),
    );
  }
}
