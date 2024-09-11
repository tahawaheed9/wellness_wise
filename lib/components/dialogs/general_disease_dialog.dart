import 'package:flutter/material.dart';

import '/controller/responsive_screen_controller.dart';
import '/components/dialogs/generic_dialog.dart';

Future<bool> showGeneralDiseaseDialog(
  BuildContext context,
  final String disease,
  final String probability,
  final String description,
  final List<dynamic> precautions,
  final List<String> symptoms,
) {
  return showGenericDialog(
    context: context,
    title: 'General Disease Prediction',
    content: SizedBox(
      height: screenHeight(context) * 0.30,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Disease Heading...
            Row(
              children: <Widget>[
                const Text(
                  'Disease:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5.0),
                Text(
                  disease,
                  softWrap: true,
                ),
              ],
            ),
            const Divider(),

            // Disease Probability...
            Row(
              children: <Widget>[
                const Text(
                  'Probability:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5.0),
                Text('$probability%'),
              ],
            ),
            const Divider(),

            // Disease Description...
            const Text(
              'Description: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Text(
              description,
              softWrap: true,
            ),
            const Divider(),

            // Disease Precautions...
            const Text(
              'Precautions: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Text(precautions.map((item) => ' — $item\n').join()),
            const Divider(),

            // User's Given Symptoms...
            const Text(
              'Symptoms: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Text(symptoms.map((item) => ' — $item\n').join()),
            const Divider(),

            // Disclaimer...
            const Text(
              'Disclaimer: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Please consult your doctor for further evaluation.',
              softWrap: true,
            )
          ],
        ),
      ),
    ),
    optionsBuilder: () => {
      'Close': true,
    },
  ).then((value) => value ?? false);
}
