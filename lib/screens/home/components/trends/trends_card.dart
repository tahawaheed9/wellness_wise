import 'package:flutter/material.dart';

import '/controller/responsive_screen_controller.dart';

class TrendsCard extends StatefulWidget {
  final String diseaseTitle;
  final String date;

  const TrendsCard({
    super.key,
    required this.diseaseTitle,
    required this.date,
  });

  @override
  State<TrendsCard> createState() => _TrendsCardState();
}

class _TrendsCardState extends State<TrendsCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context) * 0.45,
      child: Card(
        elevation: 3,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.medical_information_outlined,
                size: 32,
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Prediction:',
                textAlign: TextAlign.start,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.diseaseTitle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    widget.date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
