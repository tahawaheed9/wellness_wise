import 'package:flutter/material.dart';

showSuccessSnackBar(
  BuildContext context,
  final String message,
  final IconData icon,
) {
  return SnackBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
    behavior: SnackBarBehavior.floating,
    content: Container(
      padding: const EdgeInsets.all(16.0),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Text(
              message,
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
