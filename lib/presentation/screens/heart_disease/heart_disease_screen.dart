import 'package:flutter/material.dart';

import '/presentation/components/dialogs/generic_prediction_dialog.dart';
import '/presentation/components/dialogs/save_prediction_dialog.dart';
import '/data/services/database/database_service.dart';
import '/presentation/components/dialogs/error_dialog.dart';
import '/presentation/components/failed_snack_bar.dart';
import '/presentation/components/success_snack_bar.dart';
import '/presentation/components/primary_button.dart';
import '/data/services/disease_model/disease_model_services.dart';

class HeartDiseaseScreen extends StatefulWidget {
  const HeartDiseaseScreen({super.key});

  @override
  State<HeartDiseaseScreen> createState() => _HeartDiseaseScreenState();
}

class _HeartDiseaseScreenState extends State<HeartDiseaseScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _age;
  int? _gender;
  int? _chestPainType;
  late final TextEditingController _restingBloodPressure;
  late final TextEditingController _serumCholesterol;
  int? _restingECG;
  late final TextEditingController _maxHeartRate;
  late final TextEditingController _stDepression;
  int? _peakSTSegment;
  late final TextEditingController _majorVessels;
  int? _thalassemia;
  int? _isExerciseInducedAngina;
  int? _isFastingBloodSugar;

  List<Object> readingsList = [];

  late final DiseaseModelServices _diseaseModel;
  late final DatabaseServices _db;

  String _response = '';

  @override
  void initState() {
    super.initState();
    _age = TextEditingController();
    _restingBloodPressure = TextEditingController();
    _serumCholesterol = TextEditingController();
    _maxHeartRate = TextEditingController();
    _stDepression = TextEditingController();
    _majorVessels = TextEditingController();
    _diseaseModel = DiseaseModelServices();
    _db = DatabaseServices();
  }

  @override
  void dispose() {
    _age.dispose();
    _restingBloodPressure.dispose();
    _serumCholesterol.dispose();
    _maxHeartRate.dispose();
    _stDepression.dispose();
    _majorVessels.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Disease'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Please provide us with your medical details.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30.0),
            Form(
              key: _formKey,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  // Age Field...
                  TextFormField(
                    controller: _age,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration:
                        _decoration(labelText: 'Age', suffixText: 'years'),
                  ),

                  // Gender Field...
                  DropdownButtonFormField<int>(
                    value: _gender,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Male')),
                      DropdownMenuItem(value: 0, child: Text('Female')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Gender'),
                    onChanged: (int? value) {
                      setState(() => _gender = value);
                    },
                  ),

                  // Chest Pain Type Field...
                  DropdownButtonFormField<int>(
                    value: _chestPainType,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('Typical Angina')),
                      DropdownMenuItem(
                          value: 1, child: Text('Atypical Angina')),
                      DropdownMenuItem(
                          value: 2, child: Text('Non - Anginal Pain')),
                      DropdownMenuItem(value: 3, child: Text('Asymptotic')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Chest Pain Type'),
                    onChanged: (int? value) {
                      setState(() => _chestPainType = value);
                    },
                  ),

                  // Resting Blood Pressure Field...
                  TextFormField(
                    controller: _restingBloodPressure,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                        labelText: 'Resting Blood Pressure',
                        hintText: 'Systolic',
                        suffixText: 'mmHg'),
                  ),

                  // Serum Cholesterol Field...
                  TextFormField(
                    controller: _serumCholesterol,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                        labelText: 'Serum Cholesterol',
                        hintText: 'LDL + HDL',
                        suffixText: 'mg/dL'),
                  ),

                  // Resting ECG Field...
                  DropdownButtonFormField<int>(
                    value: _restingECG,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('Normal')),
                      DropdownMenuItem(
                          value: 1,
                          child: Text('Having ST-T Wave Abnormality')),
                      DropdownMenuItem(
                          value: 2,
                          child: Text('Left Ventricular Hypertrophy')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Resting ECG'),
                    onChanged: (int? value) {
                      setState(() => _restingECG = value);
                    },
                  ),

                  // Max Heart Rate Field...
                  TextFormField(
                    controller: _maxHeartRate,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Max Heart Rate',
                      suffixText: 'bps',
                    ),
                  ),

                  // ST Depression Field...
                  TextFormField(
                    controller: _stDepression,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'ST Depression'),
                  ),

                  // Peak ST Segment Field...
                  DropdownButtonFormField<int>(
                    value: _peakSTSegment,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('Up-sloping')),
                      DropdownMenuItem(value: 1, child: Text('Flat')),
                      DropdownMenuItem(value: 2, child: Text('Down-sloping')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Peak ST Segment'),
                    onChanged: (int? value) {
                      setState(() => _peakSTSegment = value);
                    },
                  ),

                  // Major Vessels Field...
                  TextFormField(
                    controller: _majorVessels,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Major Vessels (0 - 3)'),
                  ),

                  // Thalassemia Field...
                  DropdownButtonFormField<int>(
                    value: _thalassemia,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('Normal')),
                      DropdownMenuItem(value: 1, child: Text('Fixed Defect')),
                      DropdownMenuItem(
                          value: 2, child: Text('Reversible Defect')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Thalassemia'),
                    onChanged: (int? value) {
                      setState(() => _thalassemia = value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            CheckboxListTile(
              title: const Text('Exercise induced angina'),
              controlAffinity: ListTileControlAffinity.leading,
              value: _isExerciseInducedAngina == 1 ? true : false,
              onChanged: (bool? value) {
                setState(() {
                  value == true
                      ? _isExerciseInducedAngina = 1
                      : _isExerciseInducedAngina = 0;
                });
              },
            ),
            const SizedBox(height: 20.0),
            CheckboxListTile(
              title: const Text('Fasting Blood Sugar > 120 mg/dL'),
              controlAffinity: ListTileControlAffinity.leading,
              value: _isFastingBloodSugar == 1 ? true : false,
              onChanged: (bool? value) {
                setState(() {
                  value == true
                      ? _isFastingBloodSugar = 1
                      : _isFastingBloodSugar = 0;
                });
              },
            ),
            const SizedBox(height: 20.0),
            PrimaryButton(
              text: 'Heart Disease Prediction',
              onPressed: () async {
                await _makePrediction(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _decoration({
    required String labelText,
    String? hintText,
    String? suffixText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixText: suffixText,
      border: const OutlineInputBorder(),
    );
  }

  String? _validateForm(value) {
    if (value == null || value.toString().isEmpty) {
      return 'Required';
    }
    return null;
  }

  Future<void> _makePrediction(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        readingsList = [
          int.parse(_age.text),
          _gender!,
          _chestPainType!,
          int.parse(_restingBloodPressure.text),
          int.parse(_serumCholesterol.text),
          _isFastingBloodSugar ?? 0,
          _restingECG!,
          int.parse(_maxHeartRate.text),
          _isExerciseInducedAngina ?? 0,
          int.parse(_stDepression.text),
          _peakSTSegment!,
          int.parse(_majorVessels.text),
          _thalassemia!,
        ];
      });

      final Map<String, List<Object>> readings = {
        'readings': readingsList,
      };

      try {
        // Fetching the predictions from the model...
        await _diseaseModel
            .fetchHeartDiseasePredictions(readings)
            .then((response) async {
          setState(() => _response = response);
          if (context.mounted) {
            await showGenericPredictionDialog(
              context,
              'Heart Disease Prediction',
              _response,
            ).then(<bool>(value) async {
              if (value) {
                await showSavePredictionDialog(context)
                    .then(<bool>(value) async {
                  if (value) {
                    final createdOn = DateTime.now();
                    final Map<String, Object> data = {
                      'disease': 'Heart Disease',
                      'prediction': _response,
                      'readings': <String, Object>{
                        'age': int.parse(_age.text),
                        'gender': _gender == 1 ? 'Male' : 'Female',
                        'chest-pain-type': _chestPainType == 0
                            ? 'Typical Angina'
                            : _chestPainType == 1
                                ? 'Atypical Angina'
                                : _chestPainType == 2
                                    ? 'Non - Anginal Pain'
                                    : 'Asymptotic',
                        'systolic-resting-blood-pressure':
                            int.parse(_restingBloodPressure.text),
                        'serum-cholesterol':
                            double.parse(_serumCholesterol.text),
                        'resting-ecg': _restingECG == 0
                            ? 'Normal'
                            : _restingECG == 1
                                ? 'Having ST-T Wave Abnormality'
                                : 'Left Ventricular Hypertrophy',
                        'max-heart-rate': int.parse(_maxHeartRate.text),
                        'st-depression': double.parse(_stDepression.text),
                        'peak-st-segment': _peakSTSegment == 0
                            ? 'Up-sloping'
                            : _peakSTSegment == 1
                                ? 'Flat'
                                : 'Down-sloping',
                        'major-vessels': int.parse(_majorVessels.text),
                        'thalassemia': _thalassemia == 0
                            ? 'Normal'
                            : _thalassemia == 1
                                ? 'Fixed Defect'
                                : 'Reversible Defect',
                        'exercise-induced-angina':
                            _isExerciseInducedAngina == 1 ? 'Yes' : 'No',
                        'fasting-blood-sugar':
                            _isFastingBloodSugar == 1 ? 'Yes' : 'No',
                      },
                      'created-on': createdOn,
                    };

                    // Save data on the cloud...
                    await _savePrediction(context, data);
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
    }
  }

  Future<void> _savePrediction(
      BuildContext context, Map<String, Object> data) async {
    bool isDataSaved = false;
    try {
      await _db.addPrediction(data).whenComplete(<bool>() {
        setState(() {
          isDataSaved = true;
        });
        if (isDataSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            showSuccessSnackBar(
              context,
              'Successfully saved.',
              Icons.check_circle_outline,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            showFailedSnackBar(
              context,
              'Could not save. Please try again or contact support.',
              Icons.cancel_outlined,
            ),
          );
        }
      });
    } catch (error) {
      if (context.mounted) {
        await showErrorDialog(context, error.toString());
      }
    }
  }
}
