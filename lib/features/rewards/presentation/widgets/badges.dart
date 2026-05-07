import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/features/rewards/domain/models/badge_model.dart';

class Badges extends StatelessWidget {
  final List<BadgeModel> badges;

  const Badges({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [for (var badge in badges) BadgeWidget(badge: badge)],
    );
  }
}

class BadgeWidget extends StatelessWidget {
  final BadgeModel badge;

  const BadgeWidget({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: badge.unlocked
                ? AppColorsLight.primary.withAlpha(50)
                : AppColorsLight.primary.withAlpha(20),
          ),
          child: Opacity(
            opacity: badge.unlocked ? 1.0 : 0.45,
            child: Text(badge.icon, style: TextStyle(fontSize: 24)),
          ),
        ),
        Text(badge.name, style: AppTextStyles.bodySmall.copyWith(fontSize: 10)),
      ],
    );
  }
}
