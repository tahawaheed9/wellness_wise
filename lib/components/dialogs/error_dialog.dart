import 'package:flutter/material.dart';

import '../dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Error',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
