import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '/presentation/components/custom_filter.dart';
import '/business/models/pdf/breast_cancer_pdf_model.dart';
import '/business/models/pdf/lung_cancer_pdf_model.dart';
import '/business/models/pdf/kidney_prediction_pdf_model.dart';
import '/business/models/pdf/diabetes_prediction_pdf_model.dart';
import '/business/models/pdf/heart_disease_pdf_model.dart';
import '/business/controller/save_and_open_pdf.dart';
import '/business/models/pdf/general_disease_pdf_model.dart';
import '/presentation/components/dialogs/error_dialog.dart';
import '/data/services/database/database_service.dart';
import '/presentation/components/dialogs/delete_dialog.dart';
import '/data/services/auth/auth_service.dart';
import '/presentation/screens/history/components/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final DatabaseServices _db;

  final userId = AuthService.firebase().currentUser!.id;

  String? _selectedValue;
  DateTime? _date;

  @override
  void initState() {
    super.initState();
    _db = DatabaseServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: <Widget>[
            Icon(Icons.history_outlined),
            SizedBox(width: 5.0),
            Text('History'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
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
                      .where('created-on', isGreaterThan: _date)
                      .orderBy('created-on', descending: true)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('user-data')
                      .doc(userId)
                      .collection('predictions')
                      .orderBy('created-on', descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
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
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16.0),
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (context, _) => SizedBox(height: 30.0),
                  itemBuilder: (context, index) {
                    // Fetching the documents...
                    final DocumentSnapshot<Map<String, dynamic>> document =
                        snapshot.data!.docs[index];

                    // Fetching the data from the documents...
                    final Map<String, dynamic> data = document.data()!;

                    // Assigning the data...
                    final docId = snapshot.data!.docs[index].id;
                    final disease = data['disease'] ?? 'N/A';
                    final description =
                        data['description'] ?? data['prediction'];
                    final date = data['created-on'];

                    // Formatting the date...
                    final createdOn =
                        DateFormat.yMMMd('en_US').format(date.toDate());

                    return HistoryCard(
                      title: disease,
                      description: description,
                      date: createdOn,
                      deleteOnTap: () async {
                        await _deletePrediction(context, docId);
                      },
                      downloadOnTap: () async {
                        await _downloadRecord(docId, disease);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  DateTime? _calculateTime(String filter) {
    switch (filter) {
      case 'Past 24 hours':
        final now = DateTime.now();
        final past24Hours = now.subtract(Duration(hours: 24));
        return past24Hours;

      case 'Past 7 days':
        final now = DateTime.now();
        final pastWeek = now.subtract(Duration(days: 7));
        return pastWeek;

      case 'Past 30 days':
        final now = DateTime.now();
        final pastMonth = now.subtract(Duration(days: 30));
        return pastMonth;

      default:
        // All time case...
        return null;
    }
  }

  // Delete Prediction...
  Future<void> _deletePrediction(BuildContext context, String docId) async {
    try {
      await showDeleteDialog(context).then(<bool>(value) async {
        if (value) {
          await _db.deletePrediction(docId);
        }
      });
    } catch (error) {
      if (context.mounted) {
        await showErrorDialog(context, error.toString());
      }
    }
  }

  Future<void> _downloadRecord(String docId, String title) async {
    final userData = await _db.fetchUserData();
    final predictionData = await _db.fetchPredictionData(docId);

    switch (title) {
      case 'Heart Disease':
        final heartDisease =
            await HeartDiseasePDFModel.heartDiseasePDFStructure(
          userData,
          predictionData,
        );
        SaveAndOpenDocument.openPDF(heartDisease);
        break;

      case 'Diabetes Predictions':
        final diabetesPrediction =
            await DiabetesPredictionPdfModel.diabetesPredictionPDFStructure(
          userData,
          predictionData,
        );
        SaveAndOpenDocument.openPDF(diabetesPrediction);
        break;

      case 'Kidney Prediction':
        final kidneyPrediction =
            await KidneyPredictionPdfModel.kidneyPredictionPDFStructure(
          userData,
          predictionData,
        );
        SaveAndOpenDocument.openPDF(kidneyPrediction);
        break;

      case 'Lung Cancer':
        final lungCancer = await LungCancerPDFModel.lungCancerPDFStructure(
          userData,
          predictionData,
        );
        SaveAndOpenDocument.openPDF(lungCancer);
        break;

      case 'Breast Cancer':
        final breastCancer =
            await BreastCancerPDFModel.breastCancerPDFStructure(
          userData,
          predictionData,
        );
        SaveAndOpenDocument.openPDF(breastCancer);
        break;

      default:
        final generalDiseasePDF =
            await GeneralDiseasePDFModel.generalDiseasePDFStructure(
          userData,
          predictionData,
        );
        SaveAndOpenDocument.openPDF(generalDiseasePDF);
    }
  }
}
