import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class CommuteMode extends StatelessWidget {
  final String selectedMode;
  final ValueChanged<String> onModeSelected;

  const CommuteMode({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Commute Mode', style: AppTextStyles.headline1),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CommuteButton(
              mode: 'Walk',
              emoji: '🚶',
              isSelected: selectedMode == 'Walk',
              onPressed: () => onModeSelected('Walk'),
            ),
            CommuteButton(
              mode: 'Bike',
              emoji: '🚲',
              isSelected: selectedMode == 'Bike',
              onPressed: () => onModeSelected('Bike'),
            ),
            CommuteButton(
              mode: 'Bus',
              emoji: '🚌',
              isSelected: selectedMode == 'Bus',
              onPressed: () => onModeSelected('Bus'),
            ),
            CommuteButton(
              mode: 'Car',
              emoji: '🚗',
              isSelected: selectedMode == 'Car',
              onPressed: () => onModeSelected('Car'),
            ),
          ],
        ),
      ],
    );
  }
}

class CommuteButton extends StatelessWidget {
  final String mode;
  final String emoji;
  final bool isSelected;
  final VoidCallback onPressed;

  const CommuteButton({
    super.key,
    required this.mode,
    required this.emoji,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColorsLight.primary.withAlpha(30)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            width: 1,
          ),
        ),
        child: Text('$emoji $mode', style: AppTextStyles.body),
      ),
    );
  }
}
