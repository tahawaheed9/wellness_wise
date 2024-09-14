import 'package:flutter/material.dart';

class DiabetesPredictionsScreen extends StatelessWidget {
  const DiabetesPredictionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Predictions'),
      ),
      body: const SingleChildScrollView(),
    );
  }
}
