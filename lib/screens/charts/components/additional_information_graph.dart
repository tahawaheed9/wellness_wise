import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../services/auth/auth_service.dart';

class AdditionalInformationBarGraph extends StatefulWidget {
  const AdditionalInformationBarGraph({super.key});

  @override
  State<AdditionalInformationBarGraph> createState() =>
      _AdditionalInformationBarGraphState();
}

class _AdditionalInformationBarGraphState
    extends State<AdditionalInformationBarGraph> {
  final docId = AuthService.firebase().currentUser!.id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user-data')
          .doc(docId)
          .collection('additional-information')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No Record Found...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        } else {
          List<double> userData = [
            double.parse(snapshot.data?.docs.first['systolic-blood-pressure']),
            double.parse(snapshot.data?.docs.first['diastolic-blood-pressure']),
            double.parse(snapshot.data?.docs.first['heart-rate']),
            double.parse(snapshot.data?.docs.first['blood-sugar-levels']),
            double.parse(snapshot.data?.docs.first['cholesterol-levels']),
          ];

          BarData barData = BarData(
            systolicBloodPressure: userData[0],
            diastolicBloodPressure: userData[1],
            heartRate: userData[2],
            bloodSugarLevels: userData[3],
            cholesterolLevels: userData[4],
          );

          barData.initializeBarData();

          return SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                maxY: userData.reduce(max),
                minY: 0,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: true),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: getBottomTiles,
                    ),
                  ),
                ),
                barGroups: barData.barData
                    .map(
                      (data) => BarChartGroupData(
                        x: data.x,
                        barRods: [
                          BarChartRodData(
                            toY: data.y,
                            color: Colors.grey[800],
                            width: 30,
                            borderRadius: BorderRadius.zero,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text('sys BP');
        break;

      case 1:
        text = const Text('Dia BP');
        break;

      case 2:
        text = const Text('Heart rate');
        break;

      case 3:
        text = const Text('Sugar');
        break;

      case 4:
        text = const Text('Cholesterol');
        break;

      default:
        text = const Text('');
        break;
    }
    return SideTitleWidget(
      angle: 81.4,
      axisSide: meta.axisSide,
      child: text,
    );
  }
}

class IndividualBar {
  final int x;
  final double y;

  const IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double systolicBloodPressure;
  final double diastolicBloodPressure;
  final double heartRate;
  final double bloodSugarLevels;
  final double cholesterolLevels;

  BarData({
    required this.systolicBloodPressure,
    required this.diastolicBloodPressure,
    required this.heartRate,
    required this.bloodSugarLevels,
    required this.cholesterolLevels,
  });

  List<IndividualBar> barData = [];

  // Initializing the bar data...
  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: systolicBloodPressure),
      IndividualBar(x: 1, y: diastolicBloodPressure),
      IndividualBar(x: 2, y: heartRate),
      IndividualBar(x: 3, y: bloodSugarLevels),
      IndividualBar(x: 4, y: cholesterolLevels),
    ];
  }
}
