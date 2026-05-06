import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class Badges extends StatelessWidget {
  const Badges({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColorsLight.primary.withAlpha(50),
              ),
              child: Text('🌳', style: TextStyle(fontSize: 24)),
            ),
            Text(
              'Park guardian',
              style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColorsLight.primary.withAlpha(50),
              ),
              child: Text('🚸', style: TextStyle(fontSize: 24)),
            ),
            Text(
              'Safe walker',
              style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColorsLight.primary.withAlpha(50),
              ),
              child: Text('🌿', style: TextStyle(fontSize: 24)),
            ),
            Text(
              'Eco hero',
              style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColorsLight.primary.withAlpha(20),
              ),
              child: Opacity(
                opacity: 0.45,
                child: Text('🔒', style: TextStyle(fontSize: 24)),
              ),
            ),
            Text(
              'Mystery',
              style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
