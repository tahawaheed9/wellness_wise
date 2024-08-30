import 'package:flutter/material.dart';

import '../../../services/health/health_service.dart';
import '/components/named_divider.dart';
import '/services/database/database_service.dart';
import '/components/primary_button.dart';
import '/components/success_snack_bar.dart';
import 'sync_button.dart';

class AdditionalInformationForm extends StatefulWidget {
  const AdditionalInformationForm({super.key});

  @override
  State<AdditionalInformationForm> createState() =>
      _AdditionalInformationFormState();
}

class _AdditionalInformationFormState extends State<AdditionalInformationForm> {
  final _additionalInformationFormKey = GlobalKey<FormState>();

  final DatabaseServices _db = DatabaseServices();

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
            // Systolic Blood Pressure...
            const NamedDivider(title: 'Blood Pressure Measurements'),
            TextFormField(
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
            const SizedBox(height: 30.0),

            // Diastolic Blood Pressure...
            TextFormField(
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
            const SizedBox(height: 30.0),

            // Heart Rate Field...
            TextFormField(
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
            const SizedBox(height: 30.0),

            SyncButton(
              onPressed: () async {
                final HealthService service = HealthService();
                final List<double> data = await service.initialize();

                final double heartRate = data[0];
                final double systolic = data[1];
                final double diastolic = data[2];

                setState(() {
                  _heartRate.text = heartRate.toString();
                  _sysBloodPressure.text = systolic.toString();
                  _diaBloodPressure.text = diastolic.toString();
                });
              },
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
              onPressed: () async {
                final createdOn = DateTime.now();

                if (_additionalInformationFormKey.currentState!.validate()) {
                  Map<String, Object?> data = {
                    'systolic-blood-pressure':
                        '${double.parse(_sysBloodPressure.text)}',
                    'diastolic-blood-pressure':
                        '${double.parse(_diaBloodPressure.text)}',
                    'heart-rate': '${double.parse(_heartRate.text)}',
                    'blood-sugar-levels':
                        '${double.parse(_bloodSugarLevels.text)}',
                    'cholesterol-levels':
                        '${double.parse(_cholesterolLevels.text)}',
                    'created-on': createdOn,
                  };

                  _db.addAdditionalInformation(data);

                  ScaffoldMessenger.of(
                          _additionalInformationFormKey.currentContext!)
                      .showSnackBar(
                    showSuccessSnackBar(context),
                  );
                }
              },
            ),
            const SizedBox(height: 50.0),
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
