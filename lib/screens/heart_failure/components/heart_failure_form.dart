import 'package:flutter/material.dart';

import '/components/dialogs/heart_failure_dialog.dart';
import '/components/dialogs/save_prediction_dialog.dart';
import '/services/database/database_service.dart';
import '../../../components/dialogs/error_dialog.dart';
import '../../../components/failed_snack_bar.dart';
import '../../../components/success_snack_bar.dart';
import '/components/primary_button.dart';
import '/services/disease_model/disease_model_services.dart';

class HeartFailureForm extends StatefulWidget {
  const HeartFailureForm({super.key});

  @override
  State<HeartFailureForm> createState() => _HeartFailureFormState();
}

class _HeartFailureFormState extends State<HeartFailureForm> {
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

  bool _isDataSaved = false;

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Age & Gender Fields...
            Row(
              children: <Widget>[
                // Age Field...
                Expanded(
                  child: TextFormField(
                    controller: _age,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration:
                        _decoration(labelText: 'Age', suffixText: 'years'),
                  ),
                ),
                const SizedBox(width: 10.0),

                //Gender Field...
                Expanded(
                  child: DropdownButtonFormField<int>(
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
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Chest Pain Type & Resting Blood Pressure Fields...
            Row(
              children: <Widget>[
                // Chest Pain Type Field...
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _chestPainType,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('Typical Angina')),
                      DropdownMenuItem(
                          value: 1, child: Text('Atypical Angina')),
                      DropdownMenuItem(
                          value: 2, child: Text('Non — Anginal Pain')),
                      DropdownMenuItem(value: 3, child: Text('Asymptotic')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Chest Pain Type'),
                    onChanged: (int? value) {
                      setState(() => _chestPainType = value);
                    },
                  ),
                ),
                const SizedBox(width: 10.0),

                // Resting Blood Pressure...
                Expanded(
                  child: TextFormField(
                    controller: _restingBloodPressure,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration:
                        _decoration(labelText: 'Resting Blood Pressure'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Serum Cholesterol & Resting ECG Fields...
            Row(
              children: <Widget>[
                // Serum Cholesterol Field...
                Expanded(
                  child: TextFormField(
                    controller: _serumCholesterol,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Serum Cholesterol'),
                  ),
                ),
                const SizedBox(width: 10.0),

                // Resting ECG Field...
                Expanded(
                  child: DropdownButtonFormField<int>(
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
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Max Heart Rate & ST Depression Fields...
            Row(
              children: <Widget>[
                // Max Heart Rate Field...
                Expanded(
                  child: TextFormField(
                    controller: _maxHeartRate,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Max Heart Rate'),
                  ),
                ),
                const SizedBox(width: 10.0),

                // ST Depression Field...
                Expanded(
                  child: TextFormField(
                    controller: _stDepression,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration:
                        _decoration(labelText: 'ST Depression Exercise'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Peak Exercise ST & Number of Vessels Field...
            Row(
              children: <Widget>[
                // Peak Exercise ST Segment
                Expanded(
                  child: DropdownButtonFormField<int>(
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
                ),
                const SizedBox(width: 10.0),

                // Number of Vessels
                Expanded(
                  child: TextFormField(
                    controller: _majorVessels,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Major Vessels (0 - 3)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonFormField<int>(
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
                ),
                const SizedBox(width: 10.0),
                const Flexible(child: SizedBox()),
              ],
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
            const SizedBox(height: 30.0),
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
    String? suffixText,
  }) {
    return InputDecoration(
      labelText: labelText,
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
            .fetchHeartFailurePredictions(readings)
            .then((response) async {
          setState(() => _response = response);
          if (context.mounted) {
            await showHeartFailureDialog(
              context,
              _response,
            ).then(<bool>(value) async {
              if (value) {
                await showSavePredictionDialog(context)
                    .then(<bool>(value) async {
                  if (value) {
                    final createdOn = DateTime.now();
                    Map<String, Object> data = {
                      'prediction': _response,
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
    try {
      await _db.addPrediction(data).whenComplete(<bool>() {
        setState(() {
          _isDataSaved = true;
        });
        if (_isDataSaved) {
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
