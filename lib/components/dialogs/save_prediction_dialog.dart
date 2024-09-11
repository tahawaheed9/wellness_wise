import 'package:flutter/material.dart';
import 'package:wellness_wise/components/dialogs/generic_dialog.dart';

Future<bool> showSavePredictionDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Confirmation',
      content:
          const Text('Would you like to save this prediction for later use?'),
      optionsBuilder: () => {
        'Discard' : false,
        'Save' : true,
      }).then((value) => value ?? false);
}
