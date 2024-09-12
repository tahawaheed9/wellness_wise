import 'package:flutter/material.dart';

class HeartDiseaseScreen extends StatefulWidget {
  const HeartDiseaseScreen({super.key});

  @override
  State<HeartDiseaseScreen> createState() => _HeartDiseaseScreenState();
}

class _HeartDiseaseScreenState extends State<HeartDiseaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Disease'),
      ),
      body: const SingleChildScrollView(),
    );
  }
}
