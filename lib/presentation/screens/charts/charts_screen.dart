import 'package:flutter/material.dart';

import '/presentation/screens/charts/components/breast_cancer_chart.dart';
import '/presentation/screens/charts/components/lung_cancer_chart.dart';
import '/presentation/screens/charts/components/kidney_prediction_chart.dart';
import '/presentation/screens/charts/components/diabetes_prediction_chart.dart';
import '/presentation/screens/charts/components/heart_disease_chart.dart';
import '/presentation/screens/charts/components/all_prediction_chart.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  final List<Widget> chartList = const [
    AllPredictionChart(),
    HeartDiseaseChart(),
    DiabetesPredictionChart(),
    KidneyPredictionChart(),
    LungCancerChart(),
    BreastCancerChart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: <Widget>[
            Icon(Icons.bar_chart_outlined),
            SizedBox(width: 5.0),
            Text('Charts'),
          ],
        ),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        itemCount: chartList.length,
        separatorBuilder: (context, _) => const SizedBox(height: 50.0),
        itemBuilder: (context, index) {
          return chartList[index];
        },
      ),
    );
  }
}
