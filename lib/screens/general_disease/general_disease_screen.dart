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
  late final DiseaseModelServices _diseaseModel;
  late final DatabaseServices _db;

  List<String> symptomsList = [];

  String _disease = '';
  String _probability = '';
  String _description = '';
  List<dynamic> _precautions = [];

  @override
  void initState() {
    super.initState();
    _diseaseModel = DiseaseModelServices();
    _db = DatabaseServices();
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
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: DropdownSearch.multiSelection(
                  asyncItems: (_) => _diseaseModel.fetchSymptomList(),
                  onChanged: (selectedList) {
                    setState(() {
                      symptomsList.clear();
                      symptomsList.addAll(selectedList.cast<String>());
                    });
                  },
                  clearButtonProps: const ClearButtonProps(
                    isVisible: true,
                    tooltip: 'Clear all',
                  ),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: 'Select a symptom',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  popupProps: PopupPropsMultiSelection.menu(
                    showSearchBox: true,
                    searchDelay: const Duration(milliseconds: 1),
                    searchFieldProps: const TextFieldProps(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Search symptom',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    loadingBuilder: (context, _) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const CircularProgressIndicator(),
                            const SizedBox(height: 30.0),
                            Text(
                              'Fetching data...',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
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
        ),
      ),
    );
  }

  Future<void> _makePrediction(BuildContext context) async {
    if (symptomsList.isNotEmpty) {
      final Map<String, List<String>> symptoms = {'symptoms': symptomsList};

      try {
        // Fetch predictions from the model...
        await _diseaseModel
            .fetchGeneralDiseasePredictions(symptoms)
            .then((prediction) async {
          setState(() {
            _disease = prediction['prediction'].toString();
            _probability = prediction['probability'].toString();
            _description = prediction['disease'].toString();
            _precautions = prediction['precautions'];
          });
          if (context.mounted) {
            // Display the predictions to the user...
            await showGeneralDiseaseDialog(
              context,
              _disease,
              _probability,
              _description,
              _precautions,
              symptomsList,
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
                      'symptoms': symptomsList,
                      'created-on': createdOn,
                    };
                    // If Save, store the data on cloud...
                    await _savePrediction(data, context);
                  }
                });
              }
            });
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
}
