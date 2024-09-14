import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '/components/primary_button.dart';

class HeartFailureForm extends StatefulWidget {
  const HeartFailureForm({super.key});

  @override
  State<HeartFailureForm> createState() => _HeartFailureFormState();
}

class _HeartFailureFormState extends State<HeartFailureForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _age;
  String gender = '';
  String chestPainType = '';
  late final TextEditingController _restingBloodPressure;
  late final TextEditingController _serumCholesterol;
  String restingECG = '';
  late final TextEditingController _maxHeartRate;
  late final TextEditingController _stDepression;
  String peakSTSegment = '';
  bool? isExerciseInducedAngina = false;
  late final TextEditingController _majorVessels;
  String thalassemia = '';
  bool? isFastingBloodSugar = false;

  @override
  void initState() {
    super.initState();
    _age = TextEditingController();
    _restingBloodPressure = TextEditingController();
    _serumCholesterol = TextEditingController();
    _maxHeartRate = TextEditingController();
    _stDepression = TextEditingController();
    _majorVessels = TextEditingController();
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
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      labelText: 'Age',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixText: 'years',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),

                //Gender Field...
                Expanded(
                  child: DropdownSearch<String>(
                    items: const [
                      'male',
                      'female',
                    ],
                    onChanged: (selectedItem) {
                      setState(() {
                        gender = selectedItem.toString();
                      });
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Gender',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
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
                  child: DropdownSearch<String>(
                    items: const [
                      'typical angina',
                      'atypical angina',
                      'non — anginal pain',
                      'asymptotic',
                    ],
                    onChanged: (selectedItem) {
                      chestPainType = selectedItem.toString();
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Chest Pain Type',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
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
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      labelText: 'Resting Blood Pressure',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
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
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      labelText: 'Serum Cholesterol',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),

                // Resting ECG Field...
                Expanded(
                  child: DropdownSearch<String>(
                    items: const [
                      'normal',
                      'having ST-T wave abnormality',
                      'left ventricular hyperthrophy',
                    ],
                    onChanged: (selectedItem) {
                      restingECG = selectedItem.toString();
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Resting ECG',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
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
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      labelText: 'Max Heart Rate',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
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
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      labelText: 'ST Depression Exercise',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
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
                  child: DropdownSearch<String>(
                    items: const [
                      'upsloping',
                      'flat',
                      'downsloping',
                    ],
                    onChanged: (selectedItem) {
                      peakSTSegment = selectedItem.toString();
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Peak Exercise ST',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
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
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      labelText: 'Major Vessels (0 - 3)',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownSearch<String>(
                    items: const [
                      'normal',
                      'fixed defect',
                      'reversible defect',
                    ],
                    onChanged: (selectedItem) {
                      thalassemia = selectedItem.toString();
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Thalassemia',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
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
              value: isExerciseInducedAngina,
              onChanged: (bool? value) {
                setState(() {
                  isExerciseInducedAngina = value;
                });
              },
            ),
            const SizedBox(height: 20.0),

            CheckboxListTile(
              title: const Text('Fasting Blood Sugar > 120 mg/dL'),
              controlAffinity: ListTileControlAffinity.leading,
              value: isFastingBloodSugar,
              onChanged: (bool? value) {
                setState(() {
                  isFastingBloodSugar = value;
                });
              },
            ),
            const SizedBox(height: 30.0),
            PrimaryButton(
              text: 'Heart Disease Prediction',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
