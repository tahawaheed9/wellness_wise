import 'package:flutter/material.dart';

import '/business/controller/responsive_screen_controller.dart';
import '/presentation/components/dialogs/generic_dialog.dart';

Future<bool> showLungCancerPredictionDialog({
  required BuildContext context,
  required String message,
  required List<Object> readings,
}) async {
  return showGenericDialog(
    context: context,
    title: 'Lung Cancer Prediction',
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
                    ' — Gender:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[0] == 'M' ? 'Male' : 'Female'),
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
                  Text('${readings[1].toString()} years'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Smoking:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[2] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Yellow Fingers:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[3] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Anxiety:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[4] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Peer Pressure:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[5] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Chronic Disease:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[6] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Fatigue:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[7] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Allergy:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[8] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Wheezing:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[9] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Alcoholic:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[10] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Coughing:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[11] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Shortness of Breath:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[12] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Swallowing Difficulty:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[13] == 1 ? 'No' : 'Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Chest Pain:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[14] == 1 ? 'No' : 'Yes'),
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
