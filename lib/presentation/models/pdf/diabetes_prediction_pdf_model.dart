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
      Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Header(text: 'Wellness Wise'),
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

              // Number of pregnancies Field...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Number of pregnancies: ',
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
                    'Skin thickness value: ',
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
                    'Insulin value: ',
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
                    'BMI value: ',
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
                    'Diabetes Pedigree Function value: ',
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
