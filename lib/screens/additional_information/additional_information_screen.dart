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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Please fill in this form so that we stay up to date '
                    'with your information.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const AdditionalInformationForm(),
          ],
        ),
      ),
    );
  }
}
