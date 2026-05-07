import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class RouteFeel extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const RouteFeel({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How did the route feel?', style: AppTextStyles.headline1),
        const SizedBox(height: 16),
        Slider(
          activeColor: AppColorsLight.primary,
          value: rating.toDouble(),
          min: 1.0,
          max: 5.0,
          divisions: 4,
          label: rating.toString(),
          onChanged: (double newValue) {
            onRatingChanged(newValue.round());
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Very Bad',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Excellent',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
