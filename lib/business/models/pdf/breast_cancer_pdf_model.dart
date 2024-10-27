import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '/business/controller/save_and_open_pdf.dart';
import '/business/models/pdf/components/user_information_table.dart';

class BreastCancerPDFModel {
  static Future<File> breastCancerPDFStructure(
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
          _pageThree(predictionData),
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
      name: 'wellness_wise_breast_cancer_report.pdf',
      pdf: pdf,
    );
  }

  static Widget _pageOne(
    Map<String, dynamic> userData,
    Map<String, dynamic> predictionData,
  ) {
    final userInformationTable = UserInformationTable();
    final readings = predictionData['readings'];

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          Center(
            child: Text(
              'Breast Cancer Prediction Report',
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

          // Radius Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Radius Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['radius-mean'].toString()),
            ],
          ),
          Divider(),

          // Texture Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Texture Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['texture-mean'].toString()),
            ],
          ),
          Divider(),

          // Perimeter Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Perimeter Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['perimeter-mean'].toString()),
            ],
          ),
          Divider(),

          // Area Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Area Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['area-mean'].toString()),
            ],
          ),
          Divider(),

          // Smoothness Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Smoothness Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['smoothness-mean'].toString()),
            ],
          ),
          Divider(),

          // Compactness Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Compactness Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['compactness-mean'].toString()),
            ],
          ),
          Divider(),

          // Concavity Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Concavity Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['concavity-mean'].toString()),
            ],
          ),
          Divider(),

          // Concave Point Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Concave Points Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['concave-points-mean'].toString()),
            ],
          ),
          Divider(),

          // Symmetry Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Symmetry Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['symmetry-mean'].toString()),
            ],
          ),
          Divider(),

          // Fractal Dimension Mean Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fractal Dimension Mean: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['fractal-dimension-mean'].toString()),
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
          SizedBox(height: 100.0),

          Text(
            'Readings: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(),

          // Radius SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Radius SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['radius-se'].toString()),
            ],
          ),
          Divider(),

          // Texture SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Texture SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['texture-se'].toString()),
            ],
          ),
          Divider(),

          // Perimeter SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Perimeter SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['perimeter-se'].toString()),
            ],
          ),
          Divider(),

          // Area SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Area SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['area-se'].toString()),
            ],
          ),
          Divider(),

          // Smoothness SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Smoothness SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['smoothness-se'].toString()),
            ],
          ),
          Divider(),

          // Compactness SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Compactness SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['compactness-se'].toString()),
            ],
          ),
          Divider(),

          // Concavity SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Concavity SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['concavity-se'].toString()),
            ],
          ),
          Divider(),

          // Concave Points SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Concave Points SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['concave-points-se'].toString()),
            ],
          ),
          Divider(),

          // Symmetry SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Symmetry SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['symmetry-se'].toString()),
            ],
          ),
          Divider(),

          // Fractal Dimension SE Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fractal Dimension SE: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['fractal-dimension-se'].toString()),
            ],
          ),
          Divider(),
          SizedBox(height: 150.0),
        ],
      ),
    );
  }

  static Widget _pageThree(Map<String, dynamic> predictionData) {
    final readings = predictionData['readings'];
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 100.0),

          Text(
            'Readings: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(),

          // Radius Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Radius Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['radius-worst'].toString()),
            ],
          ),
          Divider(),

          // Texture Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Texture Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['texture-worst'].toString()),
            ],
          ),
          Divider(),

          // Perimeter Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Perimeter Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['perimeter-worst'].toString()),
            ],
          ),
          Divider(),

          // Area Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Area Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['area-worst'].toString()),
            ],
          ),
          Divider(),

          // Smoothness Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Smoothness Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['smoothness-worst'].toString()),
            ],
          ),
          Divider(),

          // Compactness Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Compactness Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['compactness-worst'].toString()),
            ],
          ),
          Divider(),

          // Concavity Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Concavity Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['concavity-worst'].toString()),
            ],
          ),
          Divider(),

          // Concave Points Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Concave Points Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['concave-points-worst'].toString()),
            ],
          ),
          Divider(),

          // Symmetry Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Symmetry Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['symmetry-worst'].toString()),
            ],
          ),
          Divider(),

          // Fractal Dimension Worst Field...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fractal Dimension Worst: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(readings['fractal-dimension-worst'].toString()),
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
