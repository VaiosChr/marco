import 'package:flutter/material.dart';
import 'package:marco/shared/widgets/custom_container.dart';

class AddAnotherChild extends StatelessWidget {
  const AddAnotherChild({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.grey),
          SizedBox(width: 8),
          Text('Add Another Child', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
