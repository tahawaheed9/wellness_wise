import 'package:flutter/material.dart';

class BreastCancerScreen extends StatefulWidget {
  const BreastCancerScreen({super.key});

  @override
  State<BreastCancerScreen> createState() => _BreastCancerScreenState();
}

class _BreastCancerScreenState extends State<BreastCancerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breast Cancer'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
