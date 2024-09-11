import 'package:flutter/material.dart';

import '../dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  final String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Error',
    content: Text(text),
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
