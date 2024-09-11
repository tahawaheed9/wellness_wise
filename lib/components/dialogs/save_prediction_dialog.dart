import 'package:flutter/material.dart';

import '/components/dialogs/generic_dialog.dart';

Future<bool> showSavePredictionDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Warning',
      content:
          const Text('Would you like to save this prediction for later use?'),
      optionsBuilder: () => {
        'Discard' : false,
        'Save' : true,
      }).then((value) => value ?? false);
}
