import 'package:flutter/material.dart';

showFailedSnackBar(BuildContext context) {
  return SnackBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
    behavior: SnackBarBehavior.floating,
    content: Container(
      padding: const EdgeInsets.all(16.0),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.check_circle_outline,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Text(
              'An error occurred. Please, Try again or Contact Support.',
              softWrap: true,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
