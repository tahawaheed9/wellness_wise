import 'package:flutter/material.dart';

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
  late final Future _future;

  late final List<String> _symptomsList;

  late final String _disease;
  late final String _probability;
  late final String _description;
  late final List<dynamic> _precautions;

  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _symptomsList = [];
    try {
      _future = _model.fetchSymptomList();
    } catch (error) {
      showErrorDialog(context, error.toString());
    }
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
                    'Could not fetch the list...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              } else if (snapshot.hasData) {
                final List<dynamic> symptoms = snapshot.data['symptoms'];
                return Column(
                  children: <Widget>[
                    Text(
                      'Please provide us with your symptoms.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 30.0),
                    DropdownButtonFormField<dynamic>(
                      value: _selectedValue,
                      hint: const Text('Select a symptom'),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                          _symptomsList.add(value);
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: symptoms.map((symptom) {
                        return DropdownMenuItem(
                          value: symptom,
                          child: Text(symptom),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 50.0),
                    PrimaryButton(
                      text: 'Predict General Disease',
                      onPressed: () async {
                        final Map<String, List<String>> symptoms = {
                          'symptoms': _symptomsList
                        };

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
                                      // If Save, store the data on cloud...
                                      print('Save on the cloud fire store...');
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
                      },
                    ),
                  ],
                );
              }
              return Center(
                child: Text(
                  'An error occurred...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
