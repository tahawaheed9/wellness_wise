import 'package:flutter/material.dart';

import '../../components/dialogs/error_dialog.dart';
import '../../components/failed_snack_bar.dart';
import '../../components/success_snack_bar.dart';
import '/components/primary_button.dart';
import '/services/database/database_service.dart';
import '/services/disease_model/disease_model_services.dart';

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

  late final TextEditingController _numberOfPregnancies;
  late final TextEditingController _glucoseLevel;
  late final TextEditingController _bloodPressureLevel;
  late final TextEditingController _skinThickness;
  late final TextEditingController _insulinValue;
  late final TextEditingController _bmiValue;
  late final TextEditingController _diabetesPedigreeFunctionValue;
  late final TextEditingController _age;

  List<Object> readingsList = [];

  String response = '';

  bool _isDataSaved = false;

  @override
  void initState() {
    super.initState();
    _diseaseModel = DiseaseModelServices();
    _db = DatabaseServices();
    _numberOfPregnancies = TextEditingController();
    _glucoseLevel = TextEditingController();
    _bloodPressureLevel = TextEditingController();
    _skinThickness = TextEditingController();
    _insulinValue = TextEditingController();
    _bmiValue = TextEditingController();
    _diabetesPedigreeFunctionValue = TextEditingController();
    _age = TextEditingController();
  }

  @override
  void dispose() {
    _numberOfPregnancies.dispose();
    _glucoseLevel.dispose();
    _bloodPressureLevel.dispose();
    _skinThickness.dispose();
    _insulinValue.dispose();
    _bmiValue.dispose();
    _diabetesPedigreeFunctionValue.dispose();
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3.0,
                  children: <Widget>[
                    // Number of Pregnancies Field...
                    TextFormField(
                      controller: _numberOfPregnancies,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      validator: _validateForm,
                      decoration: _decoration(labelText: 'Number of Pregnancies'),
                    ),

                    // Glucose Level Field...
                    TextFormField(
                      controller: _glucoseLevel,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      validator: _validateForm,
                      decoration: _decoration(labelText: 'Glucose Level'),
                    ),

                    // Systolic Blood Pressure Field...
                    TextFormField(
                      controller: _bloodPressureLevel,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      validator: _validateForm,
                      decoration: _decoration(
                        labelText: 'Blood Pressure',
                        hintText: 'Systolic',
                      ),
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
                      validator: _validateForm,
                      decoration: _decoration(labelText: 'BMI Value'),
                    ),

                    // Diabetes Pedigree Function Value Field...
                    TextFormField(
                      controller: _diabetesPedigreeFunctionValue,
                      autocorrect: false,
                      enableSuggestions: false,
                      validator: _validateForm,
                      decoration:
                      _decoration(labelText: 'Diabetes Pedigree Function'),
                    ),

                    // Age Field...
                    TextFormField(
                      controller: _age,
                      autocorrect: false,
                      enableSuggestions: false,
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
                onPressed: () {},
              ),
            ],
          ),
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
