import 'package:flutter/material.dart';

class RouteContainer extends StatelessWidget {
  final String title;
  final String description;
  final int minutes;
  final Color color;

  const RouteContainer({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    this.minutes = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text(description, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Text(
            minutes == 0 ? '--' : '$minutes min',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
