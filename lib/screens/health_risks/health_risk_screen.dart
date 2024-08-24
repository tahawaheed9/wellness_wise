import 'package:flutter/material.dart';

class HealthRiskScreen extends StatelessWidget {
  const HealthRiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Risks'),
      ),
      body: const SingleChildScrollView(),
    );
  }
}
