import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/shared/widgets/custom_container.dart';

class InviteCoparent extends StatelessWidget {
  const InviteCoparent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: AppColorsLight.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('INVITE CO-PARENT', style: AppTextStyles.headline1),
              Text('Optional', style: AppTextStyles.bodySmall),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Share the app with your co-parent to collaborate on your child\'s routes and safety.',
          ),
          SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.share),
            label: Text('Share App'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorsLight.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
