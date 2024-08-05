import 'package:flutter/material.dart';

import '/components/text_form_field.dart';
import '/components/primary_button.dart';

class BasicInformationForm extends StatefulWidget {
  const BasicInformationForm({super.key});

  @override
  State<BasicInformationForm> createState() => _BasicInformationFormState();
}

class _BasicInformationFormState extends State<BasicInformationForm> {
  final _basicInformationFormKey = GlobalKey<_BasicInformationFormState>();

  final TextEditingController age = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController lifestyleHabits = TextEditingController();
  final TextEditingController medicalHistory = TextEditingController();

  @override
  void dispose() {
    age.dispose();
    height.dispose();
    weight.dispose();
    lifestyleHabits.dispose();
    medicalHistory.dispose();
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
            MyTextFormField(
              controller: age,
              autoCorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.number,
              obscureText: false,
              maxLines: 1,
              prefixIcon: const Icon(Icons.calendar_month_outlined),
              labelText: 'Age',
              alignLabelWithHint: null,
              hintText: '0',
              suffixIcon: null,
              suffixText: null,
            ),
            const SizedBox(height: 30.0),

            // Height & Weight Fields...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Height Field...
                Expanded(
                  child: MyTextFormField(
                    controller: height,
                    autoCorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    maxLines: 1,
                    prefixIcon: const Icon(Icons.height_outlined),
                    labelText: 'Height',
                    alignLabelWithHint: null,
                    hintText: '165',
                    suffixIcon: null,
                    suffixText: 'cm',
                  ),
                ),
                const SizedBox(width: 30.0),

                // Weight Field...
                Expanded(
                  child: MyTextFormField(
                    controller: weight,
                    autoCorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    maxLines: 1,
                    prefixIcon: const Icon(Icons.monitor_weight_outlined),
                    labelText: 'Weight',
                    alignLabelWithHint: null,
                    hintText: '70',
                    suffixIcon: null,
                    suffixText: 'Kg',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),

            // Lifestyle Habits Field...
            MyTextFormField(
              controller: lifestyleHabits,
              autoCorrect: true,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              obscureText: false,
              maxLines: 3,
              prefixIcon: null,
              labelText: 'Lifestyle Habits',
              alignLabelWithHint: true,
              hintText: 'Your lifestyle habits...',
              suffixIcon: null,
              suffixText: null,
            ),
            const SizedBox(height: 30.0),

            // Medical History Field...
            MyTextFormField(
              controller: medicalHistory,
              autoCorrect: true,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              obscureText: false,
              maxLines: 3,
              prefixIcon: null,
              labelText: 'Medical History',
              alignLabelWithHint: true,
              hintText: 'Your medical history...',
              suffixIcon: null,
              suffixText: null,
            ),
            const SizedBox(height: 30.0),

            // Save Button...
            PrimaryButton(
              text: 'Save Information',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
