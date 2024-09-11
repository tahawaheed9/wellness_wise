import 'dart:async';

import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import '/components/failed_snack_bar.dart';
import '/components/success_snack_bar.dart';
import '/services/database/database_service.dart';
import '../../components/dialogs/save_prediction_dialog.dart';
import '/components/dialogs/error_dialog.dart';
import '/components/dialogs/general_disease_dialog.dart';
import '/services/disease_model/disease_model_services.dart';
import '/components/primary_button.dart';

class GeneralDiseaseScreen extends StatefulWidget {
  const GeneralDiseaseScreen({super.key});

  @override
  State<GeneralDiseaseScreen> createState() => _GeneralDiseaseScreenState();
}

class _GeneralDiseaseScreenState extends State<GeneralDiseaseScreen> {
  final DiseaseModel _model = DiseaseModel();
  final DatabaseServices _db = DatabaseServices();

  late final Future _future;

  late final List<String> _symptomsList;

  late final String _disease;
  late final String _probability;
  late final String _description;
  late final List<dynamic> _precautions;

  @override
  void initState() {
    super.initState();
    _future = _model.fetchSymptomList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Disease'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      const CircularProgressIndicator(),
                      const SizedBox(height: 30.0),
                      Text(
                        'Fetching Symptom List...',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              } else if (snapshot.hasData) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Please provide us with your symptoms.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 30.0),
                      DropdownSearch.multiSelection(
                        items: snapshot.data['symptoms'],
                        clearButtonProps: const ClearButtonProps(
                          isVisible: true,
                          tooltip: 'Clear all symptoms'
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: 'Select a symptom',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        popupProps: const PopupPropsMultiSelection.menu(
                          showSearchBox: true,
                        ),
                        onChanged: (selectedList) {
                          setState(() {
                            print(selectedList);
                          });
                        },
                      ),
                      const SizedBox(height: 50.0),
                      PrimaryButton(
                        text: 'Predict General Disease',
                        onPressed: () async {
                          await _makePrediction(context);
                        },
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: Text(
                  'No data available',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _makePrediction(BuildContext context) async {
    if (_symptomsList.isNotEmpty) {
      final Map<String, List<String>> symptoms = {'symptoms': _symptomsList};

      try {
        // Fetch predictions from the model...
        await _model
            .fetchGeneralDiseasePredictions(symptoms)
            .then((prediction) async {
          _disease = prediction['prediction'].toString();
          _probability = prediction['probability'].toString();
          _description = prediction['disease'].toString();
          _precautions = prediction['precautions'];
          if (context.mounted) {
            // Display the predictions to the user...
            await showGeneralDiseaseDialog(
              context,
              _disease,
              _probability,
              _description,
              _precautions,
              _symptomsList,
            ).then(<bool>(value) async {
              if (value) {
                // When dialog is closed, show Save dialog...
                await showSavePredictionDialog(context)
                    .then(<bool>(value) async {
                  if (value) {
                    final createdOn = DateTime.now();
                    Map<String, Object?> data = {
                      'disease': _disease,
                      'probability': _probability,
                      'description': _description,
                      'precautions': _precautions,
                      'symptoms': _symptomsList,
                      'created-on': createdOn,
                    };
                    // If Save, store the data on cloud...
                    await _savePrediction(data, context);
                  }
                });
              }
            });
          }
          if (context.mounted) {
            refreshScreen(context);
          }
        });
      } catch (error) {
        if (context.mounted) {
          await showErrorDialog(context, error.toString());
        }
      }
    } else {
      await showErrorDialog(
        context,
        'Please at least select one (1) symptom.',
      );
    }
  }

  Future<void> _savePrediction(
      Map<String, Object?> data, BuildContext context) async {
    final isDataSaved = await _db.addPrediction(data);
    if (isDataSaved) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          showSuccessSnackBar(
            context,
            'Successfully save',
            Icons.check_circle_outline,
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          showFailedSnackBar(
            context,
            'An error occurred. Please, Try again or Contact Support.',
            Icons.cancel_outlined,
          ),
        );
      }
    }
  }

  void refreshScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const GeneralDiseaseScreen(),
      ),
    );
  }
}
