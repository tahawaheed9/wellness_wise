import 'package:flutter/material.dart';

import '/controller/responsive_screen_controller.dart';

class ScreenNavigationCard extends StatelessWidget {
  final String cardTitle;
  final IconData icon;
  final VoidCallback onTap;

  const ScreenNavigationCard({
    super.key,
    required this.cardTitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: screenWidth(context) * 0.46,
        child: Card(
          elevation: 3,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  size: 32,
                ),
                const SizedBox(height: 10.0),
                Text(
                  cardTitle,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
