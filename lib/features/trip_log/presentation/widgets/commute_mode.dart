import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class CommuteMode extends StatelessWidget {
  const CommuteMode({super.key});

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
            CommuteButton(mode: 'Walk', emoji: '🚶', isSelected: true),
            CommuteButton(mode: 'Bike', emoji: '🚲'),
            CommuteButton(mode: 'Bus', emoji: '🚌'),
            CommuteButton(mode: 'Car', emoji: '🚗'),
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

  const CommuteButton({
    super.key,
    required this.mode,
    required this.emoji,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          width: 1,
        ),
      ),
      child: Text('$emoji $mode', style: AppTextStyles.body),
    );
  }
}
