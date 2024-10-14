import 'package:flutter/material.dart';

import '/business/controller/responsive_screen_controller.dart';
import '/presentation/components/dialogs/generic_dialog.dart';

Future<bool> showDiabetesPredictionDialog({
  required BuildContext context,
  required String message,
  required List<Object> readings,
}) async {
  return showGenericDialog(
    context: context,
    title: 'Diabetes Prediction',
    content: SizedBox(
      height: screenHeight(context) * 0.30,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Prediction:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Text(
              message,
              softWrap: true,
            ),
            const Divider(),

            // Readings...
            const Text(
              'Readings:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Number of Pregnancies:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[0].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Glucose Level:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${readings[1].toString()} mg/dL'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Diastolic Blood Pressure:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${readings[2].toString()} mmHg'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Skin Thickness Value:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[3].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Insulin Value:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[4].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — BMI Value:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[5].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Diabetes Pedigree Function:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[6].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Age:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${readings[7].toString()} years'),
                ],
              ),
            ),
            const Divider(),

            // Note...
            const Text(
              'Note:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Please consult your doctor for further evaluation.',
              softWrap: true,
            ),
          ],
        ),
      ),
    ),
    optionsBuilder: () => {
      'Close': true,
    },
  ).then((value) => value ?? false);
}
