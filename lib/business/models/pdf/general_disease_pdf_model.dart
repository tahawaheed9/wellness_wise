import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '/business/models/pdf/components/user_information_table.dart';
import '/business/controller/save_and_open_pdf.dart';

class GeneralDiseasePDFModel {
  static Future<File> generalDiseasePDFStructure(
    Map<String, dynamic> userData,
    Map<String, dynamic> predictionData,
  ) async {
    final userInformationTable = UserInformationTable();
    final pdf = Document();

    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Header(text: 'Wellness Wise'),
              Spacer(),

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
              Text(predictionData['symptoms'].map((item) => '$item, ').join()),
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
              Text(predictionData['precautions']
                  .map((item) => ' - $item\n')
                  .join()),
              SizedBox(height: 10.0),

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
