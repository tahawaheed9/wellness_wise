import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '/business/controller/save_and_open_pdf.dart';
import '/presentation/models/pdf/components/user_information_table.dart';

class DiabetesPredictionPdfModel {
  static Future<File> diabetesPredictionPDFStructure(
      Map<String, dynamic> userData,
      Map<String, dynamic> predictionData,
      ) async {
    final userInformationTable = UserInformationTable();
    final pdf = Document();
    final readings = predictionData['readings'];

    pdf.addPage(
      MultiPage(
        header: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text('Wellness Wise'),
            Divider(),
          ],
        ),
        maxPages: 1,
        pageFormat: PdfPageFormat.a4,
        build: (_) => <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50.0),
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

                // Number of pregnancies Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Number of Pregnancies: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['number-of-pregnancies'].toString()),
                  ],
                ),
                Divider(),

                // Glucose Level Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Glucose Level: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${readings['glucose-level']} mg/dL'),
                  ],
                ),
                Divider(),

                // Diastolic Blood Pressure Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Diastolic Blood Pressure: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${readings['blood-pressure-levels']} mmHg'),
                  ],
                ),
                Divider(),

                // Skin thickness value Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Skin Thickness Value: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['skin-thickness-value'].toString()),
                  ],
                ),
                Divider(),

                // Insulin value Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Insulin Value: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['insulin-value'].toString()),
                  ],
                ),
                Divider(),

                // BMI value Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'BMI Value: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['bmi-value'].toString()),
                  ],
                ),
                Divider(),

                // Diabetes Pedigree Function value Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Diabetes Pedigree Function Value: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['diabetes-pedigree-function-value'].toString()),
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
                SizedBox(height: 30.0),
              ],
            ),
          ),
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
      name: 'wellness_wise_diabetes_report.pdf',
      pdf: pdf,
    );
  }
}
