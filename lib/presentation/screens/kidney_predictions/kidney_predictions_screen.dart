import 'package:flutter/material.dart';

import '/presentation/components/dialogs/generic_prediction_dialog.dart';
import '/presentation/components/dialogs/save_prediction_dialog.dart';
import '/presentation/components/dialogs/error_dialog.dart';
import '/presentation/components/failed_snack_bar.dart';
import '/presentation/components/success_snack_bar.dart';
import '/data/services/database/database_service.dart';
import '/data/services/disease_model/disease_model_services.dart';
import '/presentation/components/primary_button.dart';

class KidneyPredictionsScreen extends StatefulWidget {
  const KidneyPredictionsScreen({super.key});

  @override
  State<KidneyPredictionsScreen> createState() =>
      _KidneyPredictionsScreenState();
}

class _KidneyPredictionsScreenState extends State<KidneyPredictionsScreen> {
  final _formKey = GlobalKey<FormState>();

  late final DiseaseModelServices _diseaseModel;
  late final DatabaseServices _db;

  late final TextEditingController _age;
  late final TextEditingController _systolicBloodPressure;
  late final TextEditingController _specificGravity;
  late final TextEditingController _albumin;
  late final TextEditingController _hba1c;
  int? _rbc;
  int? _pusCells;
  int? _pusCellClumps;
  int? _bacteria;
  late final TextEditingController _randomGlucose;
  late final TextEditingController _bloodUrea;
  late final TextEditingController _serumCreatinine;
  late final TextEditingController _sodium;
  late final TextEditingController _potassium;
  late final TextEditingController _hemoglobin;
  late final TextEditingController _packedCellVolume;
  late final TextEditingController _whiteBloodCell;
  late final TextEditingController _redBloodCell;
  int? _hypertension;
  int? _diabetesMellitus;
  int? _coronaryArteryDisease;
  int? _appetite;
  int? _pedalEdema;
  int? _anemia;

  List<Object> _readingsList = [];

  String _response = '';

  @override
  void initState() {
    super.initState();
    _diseaseModel = DiseaseModelServices();
    _db = DatabaseServices();
    _age = TextEditingController();
    _systolicBloodPressure = TextEditingController();
    _specificGravity = TextEditingController();
    _albumin = TextEditingController();
    _hba1c = TextEditingController();
    _randomGlucose = TextEditingController();
    _bloodUrea = TextEditingController();
    _serumCreatinine = TextEditingController();
    _sodium = TextEditingController();
    _potassium = TextEditingController();
    _hemoglobin = TextEditingController();
    _packedCellVolume = TextEditingController();
    _whiteBloodCell = TextEditingController();
    _redBloodCell = TextEditingController();
  }

  @override
  void dispose() {
    _age.dispose();
    _systolicBloodPressure.dispose();
    _specificGravity.dispose();
    _albumin.dispose();
    _hba1c.dispose();
    _randomGlucose.dispose();
    _bloodUrea.dispose();
    _serumCreatinine.dispose();
    _sodium.dispose();
    _potassium.dispose();
    _hemoglobin.dispose();
    _packedCellVolume.dispose();
    _whiteBloodCell.dispose();
    _redBloodCell.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kidney Predictions'),
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
                    decoration: _decoration(
                      labelText: 'Age',
                      suffixText: 'years',
                    ),
                  ),

                  // Systolic Blood Pressure Field...
                  TextFormField(
                    controller: _systolicBloodPressure,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Systolic Blood Pressure',
                      suffixText: 'mmHg',
                    ),
                  ),

                  // Specific Gravity Field...
                  TextFormField(
                    controller: _specificGravity,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Specific Gravity',
                    ),
                  ),

                  // Albumin Field...
                  TextFormField(
                    controller: _albumin,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Albumin',
                      suffixText: 'g/dL',
                    ),
                  ),

                  // HbA1C Field...
                  TextFormField(
                    controller: _hba1c,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'HbA1C',
                      suffixText: 'mmol/mol',
                    ),
                  ),

                  // Red Blood Cells Field...
                  DropdownButtonFormField<int>(
                    value: _rbc,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Normal')),
                      DropdownMenuItem(value: 0, child: Text('Abnormal')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Red Blood Cells (RBC)'),
                    onChanged: (value) {
                      setState(() {
                        _rbc = value;
                      });
                    },
                  ),

                  // Pus Cells Field...
                  DropdownButtonFormField<int>(
                    value: _pusCells,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Normal')),
                      DropdownMenuItem(value: 0, child: Text('Abnormal')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Pus Cells'),
                    onChanged: (value) {
                      setState(() {
                        _pusCells = value;
                      });
                    },
                  ),

                  // Pus Cell Clumps Field...
                  DropdownButtonFormField<int>(
                    value: _pusCellClumps,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Present')),
                      DropdownMenuItem(value: 0, child: Text('Not Present')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Pus Cell Clumps'),
                    onChanged: (value) {
                      setState(() {
                        _pusCellClumps = value;
                      });
                    },
                  ),

                  // Bacteria Field...
                  DropdownButtonFormField<int>(
                    value: _bacteria,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Present')),
                      DropdownMenuItem(value: 0, child: Text('Not Present')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Bacteria'),
                    onChanged: (value) {
                      setState(() {
                        _bacteria = value;
                      });
                    },
                  ),

                  // Random Blood Glucose Field...
                  TextFormField(
                    controller: _randomGlucose,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Random Blood Glucose',
                      suffixText: 'mg/dL',
                    ),
                  ),

                  // Blood Urea Field...
                  TextFormField(
                    controller: _bloodUrea,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Blood Urea',
                      suffixText: 'mg/dL',
                    ),
                  ),

                  // Serum Creatinine Field...
                  TextFormField(
                    controller: _serumCreatinine,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Serum Creatinine',
                      suffixText: 'mg/dL',
                    ),
                  ),

                  // Sodium Field...
                  TextFormField(
                    controller: _sodium,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Sodium',
                      suffixText: 'mEq',
                    ),
                  ),

                  // Potassium Field...
                  TextFormField(
                    controller: _potassium,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Potassium',
                      suffixText: 'mEq/L',
                    ),
                  ),

                  // Hemoglobin Field...
                  TextFormField(
                    controller: _hemoglobin,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Hemoglobin',
                      suffixText: 'g/dl',
                    ),
                  ),

                  // Packed Cell Volume Field...
                  TextFormField(
                    controller: _packedCellVolume,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Packed Cell Volume (PCV)',
                      suffixText: '%',
                    ),
                  ),

                  // White Blood Cell Count Field...
                  TextFormField(
                    controller: _whiteBloodCell,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'White Blood Cell (WBC)',
                      suffixText: 'cells/mcL',
                    ),
                  ),

                  // Red Blood Cell Count Field...
                  TextFormField(
                    controller: _redBloodCell,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(
                      labelText: 'Red Blood Cell (RBC)',
                      suffixText: 'cells/mcL',
                    ),
                  ),

                  // Hypertension Field...
                  DropdownButtonFormField<int>(
                    value: _hypertension,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Yes')),
                      DropdownMenuItem(value: 0, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Hypertension'),
                    onChanged: (value) {
                      setState(() {
                        _hypertension = value;
                      });
                    },
                  ),

                  // Diabetes Mellitus Field...
                  DropdownButtonFormField<int>(
                    value: _diabetesMellitus,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Yes')),
                      DropdownMenuItem(value: 0, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Diabetes Mellitus'),
                    onChanged: (value) {
                      setState(() {
                        _diabetesMellitus = value;
                      });
                    },
                  ),

                  // Coronary Artery Disease Field...
                  DropdownButtonFormField<int>(
                    value: _coronaryArteryDisease,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Yes')),
                      DropdownMenuItem(value: 0, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration:
                        _decoration(labelText: 'Coronary Artery Disease'),
                    onChanged: (value) {
                      setState(() {
                        _coronaryArteryDisease = value;
                      });
                    },
                  ),

                  // Appetite Field...
                  DropdownButtonFormField<int>(
                    value: _appetite,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Good')),
                      DropdownMenuItem(value: 0, child: Text('Poor')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Appetite'),
                    onChanged: (value) {
                      setState(() {
                        _appetite = value;
                      });
                    },
                  ),

                  // Pedal Edema...
                  DropdownButtonFormField<int>(
                    value: _pedalEdema,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Yes')),
                      DropdownMenuItem(value: 0, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Pedal Edema'),
                    onChanged: (value) {
                      setState(() {
                        _pedalEdema = value;
                      });
                    },
                  ),

                  // Anemia Field...
                  DropdownButtonFormField<int>(
                    value: _anemia,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Yes')),
                      DropdownMenuItem(value: 0, child: Text('No')),
                    ],
                    isExpanded: true,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Anemia'),
                    onChanged: (value) {
                      setState(() {
                        _anemia = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            PrimaryButton(
              text: 'Kidney Prediction',
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
        _readingsList = [
          int.parse(_age.text),
          int.parse(_systolicBloodPressure.text),
          double.parse(_specificGravity.text),
          int.parse(_albumin.text),
          int.parse(_hba1c.text),
          _rbc!,
          _pusCells!,
          _pusCellClumps!,
          _bacteria!,
          int.parse(_randomGlucose.text),
          int.parse(_bloodUrea.text),
          double.parse(_serumCreatinine.text),
          int.parse(_sodium.text),
          int.parse(_potassium.text),
          int.parse(_hemoglobin.text),
          int.parse(_packedCellVolume.text),
          int.parse(_whiteBloodCell.text),
          int.parse(_redBloodCell.text),
          _hypertension!,
          _diabetesMellitus!,
          _coronaryArteryDisease!,
          _appetite!,
          _pedalEdema!,
          _anemia!,
        ];
      });

      final Map<String, List<Object>> readings = {
        'readings': _readingsList,
      };

      try {
        await _diseaseModel
            .fetchKidneyPredictions(readings)
            .then((response) async {
          setState(() {
            _response = response;
          });
          if (context.mounted) {
            await showGenericPredictionDialog(
              context,
              'Kidney Predictions',
              _response,
            ).then(<bool>(value) async {
              if (value) {
                await showSavePredictionDialog(context)
                    .then(<bool>(value) async {
                  if (value) {
                    final createdOn = DateTime.now();

                    final Map<String, Object> data = {
                      'disease': 'Kidney Prediction',
                      'prediction': _response,
                      'readings': {
                        'age': _readingsList[0],
                        'systolic-blood-pressure': _readingsList[1],
                        'specific-gravity': _readingsList[2],
                        'albumin': _readingsList[3],
                        'hba1c': _readingsList[4],
                        'red-blood-cells':
                            _readingsList[5] == 1 ? 'Normal' : 'Abnormal',
                        'pus-cells':
                            _readingsList[6] == 1 ? 'Normal' : 'Abnormal',
                        'pus-cell-clumps':
                            _readingsList[7] == 1 ? 'Present' : 'Not Present',
                        'bacteria':
                            _readingsList[8] == 1 ? 'Present' : 'Not Present',
                        'random-blood-glucose': _readingsList[9],
                        'blood-urea': _readingsList[10],
                        'serum-creatinine': _readingsList[11],
                        'sodium': _readingsList[12],
                        'potassium': _readingsList[13],
                        'hemoglobin': _readingsList[14],
                        'packed-cell-volume': _readingsList[15],
                        'white-blood-cell-count': _readingsList[16],
                        'red-blood-cell-count': _readingsList[17],
                        'hypertension': _readingsList[18] == 1 ? 'Yes' : 'No',
                        'diabetes-mellitus':
                            _readingsList[19] == 1 ? 'Yes' : 'No',
                        'coronary-artery-disease':
                            _readingsList[20] == 1 ? 'Yes' : 'No',
                        'appetite': _readingsList[21] == 1 ? 'Good' : 'Poor',
                        'pedal-edema': _readingsList[22] == 1 ? 'Yes' : 'No',
                        'anemia': _readingsList[23] == 1 ? 'Yes' : 'No',
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
