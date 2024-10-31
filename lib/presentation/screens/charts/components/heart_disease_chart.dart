import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/data/services/auth/auth_service.dart';
import '/presentation/components/custom_filter.dart';
import '/presentation/screens/charts/components/custom_bar_chart.dart';

class HeartDiseaseChart extends StatefulWidget {
  const HeartDiseaseChart({super.key});

  @override
  State<HeartDiseaseChart> createState() => _HeartDiseaseChartState();
}

class _HeartDiseaseChartState extends State<HeartDiseaseChart> {
  final userId = AuthService.firebase().currentUser!.id;

  String? _selectedValue;
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Heart Disease Predictions',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            CustomFilter(
              onChanged: (value) {
                _selectedValue = value;
                setState(() {
                  _date = _calculateTime(_selectedValue!);
                });
              },
            ),
          ],
        ),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: (_date != null)
              ? FirebaseFirestore.instance
                  .collection('user-data')
                  .doc(userId)
                  .collection('predictions')
                  .where('disease', isEqualTo: 'Heart Disease')
                  .where('created-on', isGreaterThan: _date)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('user-data')
                  .doc(userId)
                  .collection('predictions')
                  .where('disease', isEqualTo: 'Heart Disease')
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Fetching...',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error retrieving data...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Record Found...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }

            double positiveResultsCount = 0;
            double negativeResultsCount = 0;

            for (var document in snapshot.data!.docs) {
              final Map<String, dynamic> data = document.data();
              switch (data['prediction']) {
                case 'Positive.':
                  positiveResultsCount++;
                  break;

                default:
                  negativeResultsCount++;
                  break;
              }
            }

            final List<double> countList = [
              positiveResultsCount,
              negativeResultsCount,
            ];

            return CustomBarChart(
              maxHeight: countList.reduce(max) < 2
                  ? countList.reduce(max) + 1
                  : countList.reduce(max),
              dataList: [
                BarData(
                  barData: {
                    'text': 'Positive Results',
                    'value': countList[0],
                    'color': Colors.redAccent,
                  },
                ),
                BarData(
                  barData: {
                    'text': 'Negative Results',
                    'value': countList[1],
                    'color': Colors.greenAccent,
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  DateTime? _calculateTime(String filter) {
    switch (filter) {
      case 'Past 24 hours':
        final now = DateTime.now();
        final past24Hours = now.subtract(Duration(hours: 24));
        return past24Hours;

      case 'Past week':
        final now = DateTime.now();
        final pastWeek = now.subtract(Duration(days: 7));
        return pastWeek;

      case 'Past month':
        final now = DateTime.now();
        final pastMonth = now.subtract(Duration(days: 30));
        return pastMonth;

      default:
        // All time case...
        return null;
    }
  }
}
