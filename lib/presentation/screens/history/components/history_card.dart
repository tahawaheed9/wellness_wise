import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final VoidCallback deleteOnTap;
  final VoidCallback downloadOnTap;

  const HistoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.deleteOnTap,
    required this.downloadOnTap,
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
              description,
              softWrap: true,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: deleteOnTap,
                      child: Text(
                        'Delete'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    InkWell(
                      onTap: downloadOnTap,
                      child: Text(
                        'Download'.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
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
