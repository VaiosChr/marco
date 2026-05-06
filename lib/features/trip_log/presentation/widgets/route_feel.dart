import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class RouteFeel extends StatefulWidget {
  const RouteFeel({super.key});

  @override
  State<RouteFeel> createState() => _RouteFeelState();
}

class _RouteFeelState extends State<RouteFeel> {
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How did the route feel?', style: AppTextStyles.headline1),
        const SizedBox(height: 16),
        Slider(
          activeColor: AppColorsLight.primary,
          value: _rating,
          min: 1.0,
          max: 5.0,
          divisions: 4, // 5 steps (1, 2, 3, 4, 5)
          label: _rating.toInt().toString(),
          onChanged: (double newValue) {
            setState(() {
              _rating = newValue;
            });
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
