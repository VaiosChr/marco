import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

abstract class IndicatorCard extends StatelessWidget {
  final double value;

  const IndicatorCard({super.key, required this.value});

  String get title;
  Color get color;
  double get minValue;
  double get maxValue;
  String get description;
  String get scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.body),
              Text(
                '${value.toStringAsFixed(1)} $scale',
                style: AppTextStyles.headline1.copyWith(color: color),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (maxValue > 0) ? value / maxValue : 0.0,
              backgroundColor: Theme.of(context).hoverColor,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 4),
          Text(description, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

// 1. Safety Card Implementation
class SafetyCard extends IndicatorCard {
  const SafetyCard({super.key, required super.value});

  @override
  String get title => 'Safety';

  @override
  double get minValue => 0;

  @override
  double get maxValue => 10;

  @override
  String get description {
    if (value >= 8) {
      return 'Excellent safety: well-maintained sidewalks, active crossing guards';
    } else if (value >= 5) {
      return 'Moderate safety: some sidewalks, occasional crossing guards';
    } else {
      return 'Poor safety: lack of sidewalks, no crossing guards';
    }
  }

  @override
  Color get color => getColor(value, minValue, maxValue);

  @override
  String get scale => '';
}

// 2. Noise Card Implementation
class NoiseCard extends IndicatorCard {
  const NoiseCard({super.key, required super.value}) : super();

  @override
  String get title => 'Noise';

  @override
  double get minValue => 0;

  @override
  double get maxValue => 100;

  @override
  String get description {
    if (value <= 50) {
      return 'Quiet environment.';
    } else if (value <= 70) {
      return 'Moderate noise.';
    } else {
      return 'High noise.';
    }
  }

  @override
  Color get color => getColor(value, maxValue, minValue);

  @override
  String get scale => 'dB';
}

// 3. Air Quality Card Implementation
class AirQualityCard extends IndicatorCard {
  const AirQualityCard({super.key, required super.value}) : super();

  @override
  String get title => 'Air Quality';

  @override
  double get minValue => 0;

  @override
  double get maxValue => 10;

  @override
  String get description {
    if (value >= 8) {
      return 'Good air quality: air is clean and safe.';
    } else if (value >= 5) {
      return 'Moderate air quality: acceptable for most individuals.';
    } else {
      return 'Unhealthy air quality: sensitive groups should take precautions.';
    }
  }

  @override
  Color get color => getColor(value, minValue, maxValue);

  @override
  String get scale => '';
}

Color getColor(double value, double minValue, double maxValue) {
  final normalizedValue = (value - minValue) / (maxValue - minValue);
  if (normalizedValue >= 0.8) {
    return AppColorsLight.primary;
  } else if (normalizedValue >= 0.5) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
