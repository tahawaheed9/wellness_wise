import 'package:flutter/material.dart';

import '/presentation/components/dialogs/generic_dialog.dart';

Future<bool> showConfirmRegistrationDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Confirmation',
    content: const Text(
      'You will not be able to change any information later. \n\n'
      'Are you sure you want to create an account with this information.',
      softWrap: true,
    ),
    optionsBuilder: () => {
      'Cancel': false,
      'Confirm': true,
    },
  ).then((value) => value ?? false);
}
