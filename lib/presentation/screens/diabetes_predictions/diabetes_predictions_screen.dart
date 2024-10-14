import 'package:flutter/material.dart';

import '/presentation/components/dialogs/diabetes_prediction_dialog.dart';
import '/presentation/components/dialogs/save_prediction_dialog.dart';
import '../../components/dialogs/error_dialog.dart';
import '../../components/failed_snack_bar.dart';
import '../../components/success_snack_bar.dart';
import '/presentation/components/primary_button.dart';
import '/data/services/database/database_service.dart';
import '/data/services/disease_model/disease_model_services.dart';

class DiabetesPredictionScreen extends StatefulWidget {
  const DiabetesPredictionScreen({super.key});

  @override
  State<DiabetesPredictionScreen> createState() =>
      _DiabetesPredictionScreenState();
}

class _DiabetesPredictionScreenState extends State<DiabetesPredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  late final DiseaseModelServices _diseaseModel;
  late final DatabaseServices _db;

  late final TextEditingController _pregnancies;
  late final TextEditingController _glucose;
  late final TextEditingController _bloodPressure;
  late final TextEditingController _skinThickness;
  late final TextEditingController _insulinValue;
  late final TextEditingController _bmiValue;
  late final TextEditingController _diabetesPedigreeFunction;
  late final TextEditingController _age;

  List<Object> _readingsList = [];

  String _response = '';

  @override
  void initState() {
    super.initState();
    _diseaseModel = DiseaseModelServices();
    _db = DatabaseServices();
    _pregnancies = TextEditingController();
    _glucose = TextEditingController();
    _bloodPressure = TextEditingController();
    _skinThickness = TextEditingController();
    _insulinValue = TextEditingController();
    _bmiValue = TextEditingController();
    _diabetesPedigreeFunction = TextEditingController();
    _age = TextEditingController();
  }

  @override
  void dispose() {
    _pregnancies.dispose();
    _glucose.dispose();
    _bloodPressure.dispose();
    _skinThickness.dispose();
    _insulinValue.dispose();
    _bmiValue.dispose();
    _diabetesPedigreeFunction.dispose();
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Prediction'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                  // Number of Pregnancies Field...
                  TextFormField(
                    controller: _pregnancies,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Number of Pregnancies'),
                  ),

                  // Glucose Level Field...
                  TextFormField(
                    controller: _glucose,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Glucose Level',
                      suffixText: 'mg/dL',
                    ),
                  ),

                  // Systolic Blood Pressure Field...
                  TextFormField(
                    controller: _bloodPressure,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                        labelText: 'Diastolic Blood Pressure',
                        suffixText: 'mmHg'),
                  ),

                  // Skin Thickness Value Field...
                  TextFormField(
                    controller: _skinThickness,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Skin Thickness Value'),
                  ),

                  // Insulin Value Field...
                  TextFormField(
                    controller: _insulinValue,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Insulin Value'),
                  ),

                  // BMI Value Field...
                  TextFormField(
                    controller: _bmiValue,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'BMI Value'),
                  ),

                  // Diabetes Pedigree Function Value Field...
                  TextFormField(
                    controller: _diabetesPedigreeFunction,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration:
                        _decoration(labelText: 'Diabetes Pedigree Function'),
                  ),

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
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            PrimaryButton(
              text: 'Diabetes Prediction',
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
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  Future<void> _makePrediction(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _readingsList = [
          int.parse(_pregnancies.text),
          int.parse(_glucose.text),
          int.parse(_bloodPressure.text),
          int.parse(_skinThickness.text),
          int.parse(_insulinValue.text),
          double.parse(_bmiValue.text),
          double.parse(_diabetesPedigreeFunction.text),
          int.parse(_age.text),
        ];
      });

      final Map<String, List<Object>> readings = {
        'readings': _readingsList,
      };

      try {
        // Fetching the diabetes predictions...
        await _diseaseModel
            .fetchDiabetesPredictions(readings)
            .then((response) async {
          setState(() => _response = response);
          if (context.mounted) {
            await showDiabetesPredictionDialog(
              context: context,
              message: _response,
              readings: _readingsList,
            ).then(<bool>(value) async {
              if (value) {
                await showSavePredictionDialog(context)
                    .then(<bool>(value) async {
                  if (value) {
                    final createdOn = DateTime.now();

                    final Map<String, Object> data = {
                      'disease': 'Diabetes Predictions',
                      'prediction': _response,
                      'readings': <String, Object>{
                        'number-of-pregnancies': _readingsList[0],
                        'glucose-levels': _readingsList[1],
                        'blood-pressure-levels': _readingsList[2],
                        'skin-thickness-value': _readingsList[3],
                        'insulin-value': _readingsList[4],
                        'bmi-value': _readingsList[5],
                        'diabetes-pedigree-function-value': _readingsList[6],
                        'age': _readingsList[7],
                      },
                      'created-on': createdOn,
                    };

                    // Save Predictions to the cloud...
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
