import 'package:flutter/material.dart';

import '/presentation/screens/charts/components/custom_filter.dart';
import '/presentation/screens/charts/components/custom_bar_chart.dart';

class AllPredictionChart extends StatelessWidget {
  const AllPredictionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'All Disease Predictions',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            CustomFilter(),
          ],
        ),
        CustomBarChart(
          maxHeight: 20,
          dataList: [
            BarData(
              barData: {
                'text': 'General Disease',
                'value': 18.0,
                'color': Colors.purpleAccent,
              },
            ),
            BarData(
              barData: {
                'text': 'Heart Disease',
                'value': 18.0,
                'color': Colors.greenAccent,
              },
            ),
            BarData(
              barData: {
                'text': 'Diabetes Prediction',
                'value': 18.0,
                'color': Colors.orangeAccent,
              },
            ),
            BarData(
              barData: {
                'text': 'Kidney Prediction',
                'value': 18.0,
                'color': Colors.redAccent,
              },
            ),
            BarData(
              barData: {
                'text': 'Lung Cancer',
                'value': 18.0,
                'color': Colors.blueAccent,
              },
            ),
            BarData(
              barData: {
                'text': 'Breast Cancer',
                'value': 18.0,
                'color': Colors.pinkAccent,
              },
            ),
          ],
        ),
      ],
    );
  }
}
