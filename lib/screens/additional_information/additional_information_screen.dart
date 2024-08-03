import 'package:flutter/material.dart';

import '/screens/additional_information/components/additional_information_form.dart';

class AdditionalInformationScreen extends StatelessWidget {
  const AdditionalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional Information'),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              AdditionalInformationForm(),
            ],
          ),
        ),
      ),
    );
  }
}
