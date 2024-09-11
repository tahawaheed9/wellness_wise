import 'package:flutter/material.dart';

import '../dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Log out',
    content: const Text('Are you sure you want to log out?'),
    optionsBuilder: () => {
      'Cancel': false,
      'Confirm': true,
    },
  ).then((value) => value ?? false);
}
