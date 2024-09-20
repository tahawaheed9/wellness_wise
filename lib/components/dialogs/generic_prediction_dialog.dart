import 'package:flutter/material.dart';

import '/controller/responsive_screen_controller.dart';
import '/components/dialogs/generic_dialog.dart';

Future<bool> showGenericPredictionDialog(
  BuildContext context,
  String title,
  String message,
) async {
  return showGenericDialog(
    context: context,
    title: title,
    content: SizedBox(
      height: screenHeight(context) * 0.30,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Prediction: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Text(
              message,
              softWrap: true,
            ),
            const Divider(),

            // Note...
            const Text(
              'Note: ',
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
