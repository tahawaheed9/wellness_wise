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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Please fill in this form so that we stay up to date '
                      'with your information.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 30.0),
              const BasicInformationForm(),
            ],
          ),
        ),
      ),
    );
  }
}
