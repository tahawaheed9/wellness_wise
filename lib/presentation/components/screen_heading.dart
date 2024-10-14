import 'package:flutter/material.dart';

class ScreenHeading extends StatelessWidget {
  final IconData icon;
  final String headingText;

  const ScreenHeading({
    super.key,
    required this.icon,
    required this.headingText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 27,
          ),
          const SizedBox(width: 5.0),

          Text(
            headingText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
