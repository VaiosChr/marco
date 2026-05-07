import 'package:marco/features/rewards/domain/models/badge_model.dart';
import 'package:marco/features/rewards/domain/models/daily_challenge_model.dart';

class RewardsModel {
  final String id;
  final String parentId;
  final int totalPoints;
  final int level;
  final String levelName;
  final int streakDays;
  final int nextLevelPoints;
  final List<BadgeModel> badges;
  final DailyChallengeModel? dailyChallenge;

  RewardsModel({
    required this.id,
    required this.parentId,
    required this.totalPoints,
    required this.level,
    required this.levelName,
    required this.streakDays,
    required this.nextLevelPoints,
    required this.badges,
    this.dailyChallenge,
  });

  factory RewardsModel.fromJson(Map<String, dynamic> json) {
    return RewardsModel(
      id: json['id'],
      parentId: json['parentId'],
      totalPoints: json['totalPoints'],
      level: json['level'],
      levelName: json['levelName'],
      streakDays: json['streakDays'],
      nextLevelPoints: json['nextLevelPoints'],
      badges: (json['badges'] as List)
          .map((badgeJson) => BadgeModel.fromJson(badgeJson))
          .toList(),
      dailyChallenge: json['dailyChallenge'] != null
          ? DailyChallengeModel.fromJson(json['dailyChallenge'])
          : null,
    );
  }
}
