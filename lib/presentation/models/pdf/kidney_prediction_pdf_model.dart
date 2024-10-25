import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '/business/controller/save_and_open_pdf.dart';
import '/presentation/models/pdf/components/user_information_table.dart';

class KidneyPredictionPdfModel {
  static Future<File> kidneyPredictionPDFStructure(
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
        maxPages: 2,
        pageFormat: PdfPageFormat.a4,
        build: (_) => <Widget>[
          pageOne(userData, predictionData),
          secondPage(predictionData),
        ],
        footer: (_) => Column(
          children: <Widget>[
            Divider(),
            Footer(
              title: Text(
                'Please consult your doctor for further evaluation.',
              ),
            ),
          ],
        ),
      ),
    );
    return SaveAndOpenDocument.savePDF(
      name: 'wellness_wise_kidney_report.pdf',
      pdf: pdf,
    );
  }

  static Widget pageOne(
    Map<String, dynamic> userData,
    Map<String, dynamic> predictionData,
  ) {
    final userInformationTable = UserInformationTable();
    final readings = predictionData['readings'];

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height:  50.0),
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

          // Systolic Blood Pressure Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Systolic Blood Pressure: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${readings['systolic-blood-pressure'].toString()} mmHg',
              ),
            ],
          ),
          Divider(),

          // Specific Graviy Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Specific Gravity: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['specific-gravity'].toString()),
            ],
          ),
          Divider(),

          // Albumin Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Albumin: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['albumin']} g/dL'),
            ],
          ),
          Divider(),

          // HbA1c Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'HbA1C: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['hba1c']} mmol/mol'),
            ],
          ),
          Divider(),

          // Red Blood Cells Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Red Blood Cells (RBC): ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['red-blood-cells']),
            ],
          ),
          Divider(),

          // Pus Cells Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Pus Cells: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['pus-cells']),
            ],
          ),
          Divider(),

          // Pus Cells Clumps Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Pus Cells Clumps: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['pus-cell-clumps'].toString()),
            ],
          ),
          Divider(),

          // Bacteria Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Bacteria: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['bacteria']),
            ],
          ),
          Divider(),

          // Random Blood Glucose Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Random Blood Glucose: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['random-blood-glucose']} mg/dL'),
            ],
          ),
          Divider(),

          // Blood Urea Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Blood Urea: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['random-blood-glucose']} mg/dL'),
            ],
          ),
          Divider(),

          // Serum Creatinine Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Serum Creatinine: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['serum-creatinine']} mg/dL'),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  static Widget secondPage(Map<String, dynamic> predictionData) {
    final readings = predictionData['readings'];
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 100.0),

          // Sodium Field...
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Sodium: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['sodium']} mEq'),
            ],
          ),
          Divider(),

          // Potassium Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Potassium: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['potassium']} mEq/L'),
            ],
          ),
          Divider(),

          // Hemoglobin Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Hemoglobin: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['hemoglobin']} g/dl'),
            ],
          ),
          Divider(),

          // Packed Cell Volume (PCV) Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Packed Cell Volume (PCV): ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['packed-cell-volume']} %'),
            ],
          ),
          Divider(),

          // White Blood Cell (WBC) Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'White Blood Cell (WBC): ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['white-blood-cell-count']} cells/mcL'),
            ],
          ),
          Divider(),

          // Red Blood Cell (RBC) Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Red Blood Cell (RBC): ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${readings['red-blood-cell-count']} cells/mcL'),
            ],
          ),
          Divider(),

          // Hypertension Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Hypertension: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['hypertension']),
            ],
          ),
          Divider(),

          // Diabetes Mellitus Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Diabetes Mellitus: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['diabetes-mellitus']),
            ],
          ),
          Divider(),

          // Coronary Artery Disease Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Coronary Artery Disease: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['coronary-artery-disease']),
            ],
          ),
          Divider(),

          // Appetite Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Appetite: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['appetite']),
            ],
          ),
          Divider(),

          // Pedal Edema Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Pedal Edema: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['pedal-edema']),
            ],
          ),
          Divider(),

          // Anemia Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Anemia: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['anemia']),
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
    );
  }
}
