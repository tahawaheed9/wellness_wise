import 'package:flutter/material.dart';

class HealthOutcomeScreen extends StatelessWidget {
  const HealthOutcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Outcomes'),
      ),
      body: const SingleChildScrollView(),
    );
  }
}
