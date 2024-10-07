import 'package:flutter/material.dart';

import '/components/dialogs/lung_cancer_prediction_dialog.dart';
import '/components/dialogs/save_prediction_dialog.dart';
import '/components/primary_button.dart';
import '../../components/dialogs/error_dialog.dart';
import '../../components/failed_snack_bar.dart';
import '../../components/success_snack_bar.dart';
import '/services/database/database_service.dart';
import '/services/disease_model/disease_model_services.dart';

class LungCancerScreen extends StatefulWidget {
  const LungCancerScreen({super.key});

  @override
  State<LungCancerScreen> createState() => _LungCancerScreenState();
}

class _LungCancerScreenState extends State<LungCancerScreen> {
  final _formKey = GlobalKey<FormState>();

  late final DiseaseModelServices _diseaseModel;
  late final DatabaseServices _db;

  String? _gender;
  late final TextEditingController _age;
  int? _smoking;
  int? _hasYellowFingers;
  int? _hasAnxiety;
  int? _hasPeerPressure;
  int? _hasChronicDisease;
  int? _hasFatigue;
  int? _hasAllergy;
  int? _isWheezing;
  int? _isAlcoholic;
  int? _isCoughing;
  int? _hasShortnessOfBreath;
  int? _hasSwallowingDifficulty;
  int? _hasChestPain;

  List<Object> _readingList = [];
  String _response = '';

  @override
  void initState() {
    super.initState();
    _diseaseModel = DiseaseModelServices();
    _db = DatabaseServices();
    _age = TextEditingController();
  }

  @override
  void dispose() {
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lung Cancer'),
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
                  // Gender Field...
                  DropdownButtonFormField<String>(
                    value: _gender,
                    items: const [
                      DropdownMenuItem(value: 'M', child: Text('Male')),
                      DropdownMenuItem(value: 'F', child: Text('Female')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Gender'),
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),

                  // Age Field...
                  TextFormField(
                    controller: _age,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Age',
                      suffixText: 'years',
                    ),
                  ),

                  // Smoking Field...
                  DropdownButtonFormField<int>(
                    value: _smoking,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Smoking'),
                    onChanged: (value) {
                      setState(() {
                        _smoking = value;
                      });
                    },
                  ),

                  // Yellow Fingers Field...
                  DropdownButtonFormField<int>(
                    value: _hasYellowFingers,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Yellow Fingers'),
                    onChanged: (value) {
                      setState(() {
                        _hasYellowFingers = value;
                      });
                    },
                  ),

                  // Anxiety Field...
                  DropdownButtonFormField<int>(
                    value: _hasAnxiety,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Anxiety'),
                    onChanged: (value) {
                      setState(() {
                        _hasAnxiety = value;
                      });
                    },
                  ),

                  // Peer Pressure Field...
                  DropdownButtonFormField<int>(
                    value: _hasPeerPressure,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Peer Pressure'),
                    onChanged: (value) {
                      setState(() {
                        _hasPeerPressure = value;
                      });
                    },
                  ),

                  // Chronic Disease Field...
                  DropdownButtonFormField<int>(
                    value: _hasChronicDisease,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Chronic Disease'),
                    onChanged: (value) {
                      setState(() {
                        _hasChronicDisease = value;
                      });
                    },
                  ),

                  // Fatigue Field...
                  DropdownButtonFormField<int>(
                    value: _hasFatigue,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Fatigue'),
                    onChanged: (value) {
                      setState(() {
                        _hasFatigue = value;
                      });
                    },
                  ),

                  // Allergy Field...
                  DropdownButtonFormField<int>(
                    value: _hasAllergy,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Allergy'),
                    onChanged: (value) {
                      setState(() {
                        _hasAllergy = value;
                      });
                    },
                  ),

                  // Wheezing Field...
                  DropdownButtonFormField<int>(
                    value: _isWheezing,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Wheezing'),
                    onChanged: (value) {
                      setState(() {
                        _isWheezing = value;
                      });
                    },
                  ),

                  // Alcoholic Field...
                  DropdownButtonFormField<int>(
                    value: _isAlcoholic,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Alcoholic'),
                    onChanged: (value) {
                      setState(() {
                        _isAlcoholic = value;
                      });
                    },
                  ),

                  DropdownButtonFormField<int>(
                    value: _isCoughing,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Coughing'),
                    onChanged: (value) {
                      setState(() {
                        _isCoughing = value;
                      });
                    },
                  ),

                  // Shortness of Breath Field...
                  DropdownButtonFormField<int>(
                    value: _hasShortnessOfBreath,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Shortness of Breath'),
                    onChanged: (value) {
                      setState(() {
                        _hasShortnessOfBreath = value;
                      });
                    },
                  ),

                  // Swallowing Difficulty Field...
                  DropdownButtonFormField<int>(
                    value: _hasSwallowingDifficulty,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Swallowing Difficulty'),
                    onChanged: (value) {
                      setState(() {
                        _hasSwallowingDifficulty = value;
                      });
                    },
                  ),

                  // Chest Pain Field...
                  DropdownButtonFormField<int>(
                    value: _hasChestPain,
                    items: const [
                      DropdownMenuItem(value: 2, child: Text('Yes')),
                      DropdownMenuItem(value: 1, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Chest Pain'),
                    onChanged: (value) {
                      setState(() {
                        _hasChestPain = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            PrimaryButton(
              text: 'Lung Cancer Prediction',
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
        _readingList = [
          _gender!,
          int.parse(_age.text),
          _smoking!,
          _hasYellowFingers!,
          _hasAnxiety!,
          _hasPeerPressure!,
          _hasChronicDisease!,
          _hasFatigue!,
          _hasAllergy!,
          _isWheezing!,
          _isAlcoholic!,
          _isCoughing!,
          _hasShortnessOfBreath!,
          _hasSwallowingDifficulty!,
          _hasChestPain!,
        ];
      });

      final Map<String, List<Object>> readings = {
        'readings': _readingList,
      };

      try {
        await _diseaseModel
            .fetchLungCancerPredictions(readings)
            .then((response) async {
          setState(() {
            _response = response;
          });
          if (context.mounted) {
            await showLungCancerPredictionDialog(
              context: context,
              message: _response,
              readings: _readingList,
            ).then(<bool>(value) async {
              if (value) {
                await showSavePredictionDialog(context)
                    .then(<bool>(value) async {
                  if (value) {
                    final createdOn = DateTime.now();

                    final Map<String, Object> data = {
                      'disease': 'Lung Cancer',
                      'prediction': _response,
                      'readings': {
                        'gender': _readingList[0] == 'M' ? 'Male' : 'Female',
                        'age': _readingList[1],
                        'smoking': _readingList[2] == 1 ? 'No' : 'Yes',
                        'yellow-fingers': _readingList[3] == 1 ? 'No' : 'Yes',
                        'anxiety': _readingList[4] == 1 ? 'No' : 'Yes',
                        'peer-pressure': _readingList[5] == 1 ? 'No' : 'Yes',
                        'chronic-disease': _readingList[6] == 1 ? 'No' : 'Yes',
                        'fatigue': _readingList[7] == 1 ? 'No' : 'Yes',
                        'allergy': _readingList[8] == 1 ? 'No' : 'Yes',
                        'wheezing': _readingList[9] == 1 ? 'No' : 'Yes',
                        'alcoholic': _readingList[10] == 1 ? 'No' : 'Yes',
                        'coughing': _readingList[11] == 1 ? 'No' : 'Yes',
                        'shortness-of-breath':
                            _readingList[12] == 1 ? 'No' : 'Yes',
                        'swallowing-difficulty':
                            _readingList[13] == 1 ? 'No' : 'Yes',
                        'chest-pain': _readingList[14] == 1 ? 'No' : 'Yes',
                      },
                      'created-on': createdOn,
                    };

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
