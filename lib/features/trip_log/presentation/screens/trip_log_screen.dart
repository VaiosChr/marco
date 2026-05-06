import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/features/trip_log/presentation/widgets/commute_mode.dart';
import 'package:marco/features/trip_log/presentation/widgets/route_container.dart';
import 'package:marco/features/trip_log/presentation/widgets/route_feel.dart';
import 'package:marco/shared/widgets/custom_buttons.dart';

class TripLogScreen extends StatelessWidget {
  const TripLogScreen({super.key});

  String _formatDate(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_formatDate(date), style: AppTextStyles.title),
            Text('Log today\'s trip', style: AppTextStyles.body),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Which route did you take?', style: AppTextStyles.headline1),
              Text(
                'No GPS tracking - you tell us',
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: 16),
              RouteContainer(
                title: 'Usual route',
                description: 'Via Egnatia street',
                minutes: 12,
                color: Colors.grey.withAlpha(50),
              ),
              const SizedBox(height: 12),
              RouteContainer(
                title: '⭐ MARCO suggestion',
                description: 'Via Pavlou Mela park',
                minutes: 15,
                color: AppColorsLight.primary.withAlpha(50),
              ),
              const SizedBox(height: 12),
              RouteContainer(
                title: 'Other route',
                description: 'I\'ll describe it',
                color: Colors.grey.withAlpha(50),
              ),
              const SizedBox(height: 12),
              const CommuteMode(),
              const SizedBox(height: 12),
              const RouteFeel(),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomButton(onPressed: () {}, text: 'Save Trip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
