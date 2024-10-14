import 'package:flutter/material.dart';

class NamedDivider extends StatelessWidget {
  final String title;

  const NamedDivider({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30.0),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
