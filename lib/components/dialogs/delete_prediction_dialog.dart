import 'package:flutter/material.dart';

import '../dialogs/generic_dialog.dart';

Future<bool> showDeletePredictionDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Alert',
    content: const Text('Are you sure you want to delete this record?'),
    optionsBuilder: () => {
      'Cancel': false,
      'Confirm': true,
    },
  ).then((value) => value ?? false);
}
