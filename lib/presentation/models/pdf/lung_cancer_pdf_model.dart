import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '/business/controller/save_and_open_pdf.dart';
import '/presentation/models/pdf/components/user_information_table.dart';

class LungCancerPDFModel {
  static Future<File> lungCancerPDFStructure(
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
          children: <Widget>[
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
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    'Lung Cancer Prediction Report',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

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

                // Smoking Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Smoking: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['smoking']),
                  ],
                ),
                Divider(),

                // Yellow Fingers Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Yellow Fingers: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['yellow-fingers']),
                  ],
                ),
                Divider(),

                // Anxiety Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Anxiety: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['anxiety']),
                  ],
                ),
                Divider(),

                // Peer Pressure Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Peer Pressure: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['peer-pressure']),
                  ],
                ),
                Divider(),

                //  Chronic Disease Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Chronic Disease: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['chronic-disease']),
                  ],
                ),
                Divider(),

                // Fatigue Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Fatigue: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['fatigue']),
                  ],
                ),
                Divider(),

                // Allergy Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Allergy: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['allergy']),
                  ],
                ),
                Divider(),

                // Wheezing Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Wheezing: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['wheezing']),
                  ],
                ),
                Divider(),

                // Alcoholic Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Alcoholic: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['alcoholic']),
                  ],
                ),
                Divider(),

                // Coughing Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Coughing: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['coughing']),
                  ],
                ),
                Divider(),

                // Shortness of Breath Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Shortness of Breath: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['shortness-of-breath']),
                  ],
                ),
                Divider(),

                // Swallowing Difficulty Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Swallowing Difficulty: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['swallowing-difficulty']),
                  ],
                ),
                Divider(),

                // Chest Pain Field...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Chest Pain: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(readings['chest-pain']),
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
      name: 'wellness_wise_lung_cancer_report.pdf',
      pdf: pdf,
    );
  }
}
