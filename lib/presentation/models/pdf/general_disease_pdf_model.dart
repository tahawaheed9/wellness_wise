import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '/presentation/models/pdf/components/user_information_table.dart';
import '/business/controller/save_and_open_pdf.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class GeneralDiseasePDFModel {
  static Future<File> generalDiseasePDFStructure(
    Map<String, dynamic> userData,
    Map<String, dynamic> predictionData,
  ) async {
    final userInformationTable = UserInformationTable();
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
        maxPages: 1,
        pageFormat: PdfPageFormat.a4,
        build: (_) => <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50.0),

                // User Information...
                userInformationTable.userInformationTable(
                  userData,
                  predictionData,
                ),

                // Symptoms...
                Text(
                  'Symptoms: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  predictionData['symptoms'].map((item) => '$item, ').join(),
                  softWrap: true,
                ),
                Divider(),
                SizedBox(height: 10.0),

                // Title...
                Row(
                  children: <Widget>[
                    Text(
                      'Disease: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5.0),
                    Text(predictionData['disease']),
                  ],
                ),
                Divider(),
                SizedBox(height: 10.0),

                // Probability...
                Row(
                  children: <Widget>[
                    Text(
                      'Probability: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5.0),
                    Text('${predictionData['probability']} %'),
                  ],
                ),
                Divider(),
                SizedBox(height: 10.0),

                // Description...
                Text(
                  'Description: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(predictionData['description'], softWrap: true),
                Divider(),
                SizedBox(height: 10.0),

                // Precautions...
                Text(
                  'Precautions: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                for (var precaution in predictionData['precautions'])
                  Bullet(text: precaution.toString().capitalize()),
                SizedBox(height: 10.0),
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
      name: 'wellness_wise_general_disease_report.pdf',
      pdf: pdf,
    );
  }
}
