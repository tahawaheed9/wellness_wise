import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '/business/controller/save_and_open_pdf.dart';
import '/business/models/pdf/components/user_information_table.dart';

class HeartDiseasePDFModel {
  static Future<File> heartDiseasePDFStructure(
    Map<String, dynamic> userData,
    Map<String, dynamic> predictionData,
  ) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        header: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Wellness Wise'),
            Divider(),
          ],
        ),
        pageFormat: PdfPageFormat.a4,
        build: (_) => <Widget>[
          _pageOne(userData, predictionData),
          _pageTwo(predictionData),
        ],
        footer: (_) => Column(
          children: <Widget>[
            Divider(),
            Text('Please consult your doctor for further evaluation.'),
          ],
        ),
      ),
    );
    return SaveAndOpenDocument.savePDF(
      name: 'wellness_wise_heart_report.pdf',
      pdf: pdf,
    );
  }

  static Widget _pageOne(Map<String, dynamic> userData, Map<String, dynamic> predictionData) {
    final userInformationTable = UserInformationTable();
    final readings = predictionData['readings'];

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          Center(
            child: Text(
              'Heart Disease Prediction Report',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
              ),
            ),
          ),
          SizedBox(height: 30.0),

          // User Information Table...
          userInformationTable.userInformationTable(
            userData,
            predictionData,
          ),
          Text(
            'Readings: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(),

          // Chest Pain Type Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Chest Pain Type: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['chest-pain-type']),
            ],
          ),
          Divider(),

          // Resting Blood Pressure Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Resting Blood Pressure (Systolic): ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['systolic-resting-blood-pressure']} mmHg'),
            ],
          ),
          Divider(),

          // Serum Cholesterol Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Serum Cholesterol (LDL + HDL): ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['serum-cholesterol']} mg/dL'),
            ],
          ),
          Divider(),

          // Resting ECG Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Resting ECG: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['resting-ecg']),
            ],
          ),
          Divider(),

          // Max Heart Rate...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Max Heart Rate: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['max-heart-rate']} bps'),
            ],
          ),
          Divider(),

          // ST Depression Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'ST Depression: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['st-depression'].toString()),
            ],
          ),
          Divider(),

          // Peak ST Segment Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Peak ST Segment: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['peak-st-segment']),
            ],
          ),
          Divider(),

          // Major Vessels Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Major Vessels: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['major-vessels'].toString()),
            ],
          ),
          Divider(),

          // Thalassemia Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Thalassemia: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['thalassemia']),
            ],
          ),
          Divider(),

          // Exercise Induced Angina Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Exercise Induced Angina: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['exercise-induced-angina']),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  static Widget _pageTwo(Map<String, dynamic> predictionData) {
    final readings = predictionData['readings'];
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 70.0),

          Text(
            'Readings: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(),

          // Fasting Blood Sugar Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fasting Blood Sugar > 120 mg/dL: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['fasting-blood-sugar']),
            ],
          ),
          Divider(),
          SizedBox(height: 30.0),

          // Prediction Result...
          Row(
            children: <Widget>[
              Text(
                'Result: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Text(predictionData['prediction']),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
