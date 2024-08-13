import 'package:flutter/material.dart';

import '/components/dialogs/generic_dialog.dart';

Future<bool> showConfirmRegistrationDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Confirmation',
    content:
        'Please verify your information as you will not be able to edit except, '
        'the age\n\n Create an account with the provided information?',
    optionsBuilder: () => {
      'Cancel': false,
      'Confirm': true,
    },
  ).then((value) => value ?? false);
}
