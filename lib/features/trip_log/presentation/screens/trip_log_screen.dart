import 'package:flutter/material.dart';

class TripLogScreen extends StatelessWidget {
  const TripLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip Log')),
      body: const Center(child: Text('Your trip logs will appear here!')),
    );
  }
}
