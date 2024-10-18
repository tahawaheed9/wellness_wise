import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.body,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text(
              body,
              softWrap: true,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: onTap,
                  child: Text(
                    'Delete'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(date),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
