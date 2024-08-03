import 'package:flutter/material.dart';

import '/screens/basic_information/components/basic_information_form.dart';

class BasicInformationScreen extends StatelessWidget {
  const BasicInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Information'),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              BasicInformationForm(),
            ],
          ),
        ),
      ),
    );
  }
}
