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
    final userInformationTable = UserInformationTable();
    final pdf = Document();
    final readings = predictionData['readings'];

    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Header(text: 'Heart Disease'),
              Spacer(),

              // User Information Table...
              userInformationTable.userInformationTable(
                userData,
                predictionData,
              ),

              // Readings Table...
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
                    'ST Depression',
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
                    'Exercise induced angina: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings['exercise-induced-angina']),
                ],
              ),
              Divider(),

              // Fasting Blood Sugar Field...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Fasting blood sugar > 120 mg/dL: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(readings['fasting-blood-sugar']),
                ],
              ),
              Divider(),
              SizedBox(height: 30.0),

              // Prediction Result...
              Divider(),
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
              SizedBox(height: 30.0),

              Spacer(),
              Divider(),
              Footer(
                title: Text(
                  'Please consult your doctor for further evaluation.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return SaveAndOpenDocument.savePDF(
      name: 'wellness_wise_report.pdf',
      pdf: pdf,
    );
  }
}
