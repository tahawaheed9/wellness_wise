import 'package:flutter/material.dart';

import '/components/named_divider.dart';
import '/services/database/data_services.dart';
import '/components/primary_button.dart';

class AdditionalInformationForm extends StatefulWidget {
  const AdditionalInformationForm({super.key});

  @override
  State<AdditionalInformationForm> createState() =>
      _AdditionalInformationFormState();
}

class _AdditionalInformationFormState extends State<AdditionalInformationForm> {
  final _additionalInformationFormKey = GlobalKey<FormState>();

  late final DatabaseServices _db = DatabaseServices();

  late final TextEditingController _sysBloodPressure;
  late final TextEditingController _diaBloodPressure;
  late final TextEditingController _heartRate;
  late final TextEditingController _bloodSugarLevels;
  late final TextEditingController _cholesterolLevels;

  @override
  void initState() {
    super.initState();
    _sysBloodPressure = TextEditingController();
    _diaBloodPressure = TextEditingController();
    _heartRate = TextEditingController();
    _bloodSugarLevels = TextEditingController();
    _cholesterolLevels = TextEditingController();
  }

  @override
  void dispose() {
    _sysBloodPressure.dispose();
    _diaBloodPressure.dispose();
    _heartRate.dispose();
    _bloodSugarLevels.dispose();
    _cholesterolLevels.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _additionalInformationFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Blood Pressure & Heart Rate Fields...
            const NamedDivider(title: 'Blood Pressure'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Blood Pressure Field...

                Expanded(
                  child: TextFormField(
                    controller: _sysBloodPressure,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: const InputDecoration(
                      labelText: 'Systolic',
                      suffixText: 'mmHg',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),

                Expanded(
                  child: TextFormField(
                    controller: _diaBloodPressure,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: const InputDecoration(
                      labelText: 'Diastolic',
                      suffixText: 'mmHg',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),

                // Heart Rate Field...
                Expanded(
                  child: TextFormField(
                    controller: _heartRate,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: const InputDecoration(
                      labelText: 'Heart Rate',
                      suffixText: 'bpm',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            // Blood Sugar Level Field...
            const NamedDivider(title: 'Fasting Glucose Levels'),
            TextFormField(
              controller: _bloodSugarLevels,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.number,
              validator: _validateForm,
              decoration: const InputDecoration(
                labelText: 'Blood Sugar Levels',
                suffixText: 'mg/dL',
                border: OutlineInputBorder(),
              ),
            ),

            // Cholesterol Levels Field...
            const NamedDivider(title: 'Lipids Profile'),
            TextFormField(
              controller: _cholesterolLevels,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.number,
              validator: _validateForm,
              decoration: const InputDecoration(
                labelText: 'Cholesterol Levels',
                hintText: 'LDL + HDL',
                suffixText: 'mg/dL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 50.0),

            // Save Information Button...
            PrimaryButton(
              text: 'Save Information',
              onPressed: () {
                if (_additionalInformationFormKey.currentState!.validate()) {
                  Map<String, Object?> data = {
                    'systolic-blood-pressure':
                        '${int.parse(_sysBloodPressure.text)}',
                    'diastolic-blood-pressure':
                        '${int.parse(_diaBloodPressure.text)}',
                    'heart-rate': '${int.parse(_heartRate.text)}',
                    'blood-sugar-levels':
                        '${double.parse(_bloodSugarLevels.text)}',
                    'cholesterol-levels':
                        '${double.parse(_cholesterolLevels.text)}',
                  };
                  _db.updateAdditionalInformation(data);
                  ScaffoldMessenger.of(
                          _additionalInformationFormKey.currentContext!)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        'Successfully updated.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.green,
                            ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String? _validateForm(value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }
}
