import 'package:flutter/material.dart';

import '/presentation/screens/charts/components/custom_bar_chart.dart';
import '/presentation/screens/charts/components/custom_filter.dart';

class KidneyPredictionChart extends StatelessWidget {
  const KidneyPredictionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kidney Predictions',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomFilter(),
          ],
        ),
        CustomBarChart(
          maxHeight: 10,
          dataList: [
            BarData(
              barData: {
                'text': 'Positive Results',
                'value': 5.0,
                'color': Colors.redAccent,
              },
            ),
            BarData(
              barData: {
                'text': 'Negative Results',
                'value': 5.0,
                'color': Colors.greenAccent,
              },
            ),
          ],
        ),
      ],
    );
  }
}
