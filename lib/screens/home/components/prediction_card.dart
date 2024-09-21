import 'package:flutter/material.dart';

import '/controller/responsive_screen_controller.dart';

class PredictionCard extends StatefulWidget {
  final String diseaseTitle;
  final String date;

  const PredictionCard({
    super.key,
    required this.diseaseTitle,
    required this.date,
  });

  @override
  State<PredictionCard> createState() => _PredictionCardState();
}

class _PredictionCardState extends State<PredictionCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
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
