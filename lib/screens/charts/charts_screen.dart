import 'package:flutter/material.dart';

import '/components/named_divider.dart';
import '/screens/charts/components/additional_information_graph.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const NamedDivider(title: 'Additional Information'),
              const AdditionalInformationBarGraph(),
              const SizedBox(height: 50.0),
              Text(
                'Note: More graphs will be added once health predictions are made.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
