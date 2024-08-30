import 'package:flutter/material.dart';

import '/components/failed_snack_bar.dart';
import '/components/success_snack_bar.dart';
import '/services/database/database_service.dart';
import '/components/primary_button.dart';

class BasicInformationForm extends StatefulWidget {
  const BasicInformationForm({super.key});

  @override
  State<BasicInformationForm> createState() => _BasicInformationFormState();
}

class _BasicInformationFormState extends State<BasicInformationForm> {
  final _basicInformationFormKey = GlobalKey<FormState>();

  late final DatabaseServices _db = DatabaseServices();
  late final TextEditingController _age;
  late final TextEditingController _height;
  late final TextEditingController _weight;
  late final TextEditingController _lifestyleHabits;
  late final TextEditingController _medicalHistory;

  @override
  void initState() {
    super.initState();
    _age = TextEditingController();
    _height = TextEditingController();
    _weight = TextEditingController();
    _lifestyleHabits = TextEditingController();
    _medicalHistory = TextEditingController();
  }

  @override
  void dispose() {
    _age.dispose();
    _height.dispose();
    _weight.dispose();
    _lifestyleHabits.dispose();
    _medicalHistory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _basicInformationFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Age Field...
            TextFormField(
              controller: _age,
              keyboardType: TextInputType.number,
              validator: _validateForm,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Height Field...
            TextFormField(
              controller: _height,
              keyboardType: TextInputType.number,
              validator: _validateForm,
              decoration: const InputDecoration(
                labelText: 'Height',
                suffixText: 'cm',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Weight Field...
            TextFormField(
              controller: _weight,
              keyboardType: TextInputType.number,
              validator: _validateForm,
              decoration: const InputDecoration(
                labelText: 'Weight',
                suffixText: 'Kg',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Lifestyle Habits Field...
            TextFormField(
              controller: _lifestyleHabits,
              maxLines: 3,
              validator: _validateForm,
              decoration: const InputDecoration(
                labelText: 'Lifestyle Habits',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Medical History Field...
            TextFormField(
              controller: _medicalHistory,
              maxLines: 3,
              validator: _validateForm,
              decoration: const InputDecoration(
                labelText: 'Medical History',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),

            // Save Button...
            PrimaryButton(
              text: 'Save Information',
              onPressed: () async {
                if (_basicInformationFormKey.currentState!.validate()) {
                  Map<String, Object?> data = {
                    'age': int.parse(_age.text),
                    'height': '${double.parse(_height.text)}',
                    'weight': '${double.parse(_weight.text)}',
                    'lifestyle-habits': _lifestyleHabits.text,
                    'medical-history': _medicalHistory.text,
                  };

                  final isDataSaved = await _db.addBasicInformation(data);

                  if (isDataSaved == null) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                              _basicInformationFormKey.currentContext!)
                          .showSnackBar(
                        showSuccessSnackBar(context),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                              _basicInformationFormKey.currentContext!)
                          .showSnackBar(showFailedSnackBar(context));
                    }
                  }
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
