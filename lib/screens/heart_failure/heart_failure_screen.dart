import 'package:flutter/material.dart';

import '/screens/heart_failure/components/heart_failure_form.dart';

class HeartFailureScreen extends StatefulWidget {
  const HeartFailureScreen({super.key});

  @override
  State<HeartFailureScreen> createState() => _HeartFailureScreenState();
}

class _HeartFailureScreenState extends State<HeartFailureScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Failure'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeartFailureForm(),
          ],
        ),
      ),
    );
  }
}
