import 'package:flutter/material.dart';

class RouteEntryScreen extends StatelessWidget {
  final String childId;
  const RouteEntryScreen({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route Entry')),
      body: Center(child: Text('Starting route for child ID: $childId')),
    );
  }
}
