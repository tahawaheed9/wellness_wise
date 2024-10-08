import 'package:flutter/material.dart';

import '/controller/responsive_screen_controller.dart';
import '/components/dialogs/generic_dialog.dart';

Future<bool> showBreastCancerPredictionDialog({
  required BuildContext context,
  required String message,
  required List<Object> readings,
}) async {
  return showGenericDialog(
    context: context,
    title: 'Breast Cancer Prediction',
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
                    ' — Radius Mean:',
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
                    ' — Area Mean:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[1].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Concavity Mean:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[2].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Texture Mean:',
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
                    ' — Smoothness Mean:',
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
                    ' — Concave Points Mean:',
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
                    ' — Perimeter Mean:',
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
                    ' — Compactness Mean:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[7].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Symmetry Mean:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[8].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Fractal Dimension Mean:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[9].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Perimeter SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[10].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Compactness SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[11].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Radius SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[12].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Area SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[13].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Concavity SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[14].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Texture SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[15].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Smoothness SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[16].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Concave Points SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[17].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Symmetry SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[18].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Radius Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[19].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Area Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[20].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Fractal Dimension SE:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[21].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Texture Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[22].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Smoothness Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[23].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Concavity Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[24].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Perimeter Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[25].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Compactness Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[26].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Concave Points Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[27].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Fractal Dimension Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[28].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    ' — Symmetry Worst:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings[29].toString()),
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
