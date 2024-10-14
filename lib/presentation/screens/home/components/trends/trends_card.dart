import 'package:flutter/material.dart';

import '/business/controller/responsive_screen_controller.dart';

class TrendsCard extends StatelessWidget {
  final String diseaseTitle;
  final String date;

  const TrendsCard({
    super.key,
    required this.diseaseTitle,
    required this.date,
  });

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
                diseaseTitle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    date,
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
