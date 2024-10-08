import 'package:flutter/material.dart';

import '/components/dialogs/breast_cancer_prediction_dialog.dart';
import '/components/dialogs/save_prediction_dialog.dart';
import '../../components/dialogs/error_dialog.dart';
import '../../components/failed_snack_bar.dart';
import '../../components/primary_button.dart';
import '../../components/success_snack_bar.dart';
import '/services/database/database_service.dart';
import '/services/disease_model/disease_model_services.dart';

class BreastCancerScreen extends StatefulWidget {
  const BreastCancerScreen({super.key});

  @override
  State<BreastCancerScreen> createState() => _BreastCancerScreenState();
}

class _BreastCancerScreenState extends State<BreastCancerScreen> {
  final _formKey = GlobalKey<FormState>();

  late final DiseaseModelServices _diseaseModel;
  late final DatabaseServices _db;

  late final TextEditingController _radiusMean;
  late final TextEditingController _areaMean;
  late final TextEditingController _concavityMean;
  late final TextEditingController _textureMean;
  late final TextEditingController _smoothnessMean;
  late final TextEditingController _concavePointsMean;
  late final TextEditingController _perimeterMean;
  late final TextEditingController _compactnessMean;
  late final TextEditingController _symmetryMean;
  late final TextEditingController _fractalDimensionMean;
  late final TextEditingController _perimeterSE;
  late final TextEditingController _compactnessSE;
  late final TextEditingController _radiusSE;
  late final TextEditingController _areaSE;
  late final TextEditingController _concavitySE;
  late final TextEditingController _textureSE;
  late final TextEditingController _smoothnessSE;
  late final TextEditingController _concavePointsSE;
  late final TextEditingController _symmetrySE;
  late final TextEditingController _radiusWorst;
  late final TextEditingController _areaWorst;
  late final TextEditingController _fractalDimensionSE;
  late final TextEditingController _textureWorst;
  late final TextEditingController _smoothnessWorst;
  late final TextEditingController _concavityWorst;
  late final TextEditingController _perimeterWorst;
  late final TextEditingController _compactnessWorst;
  late final TextEditingController _concavePointsWorst;
  late final TextEditingController _fractalDimensionWorst;
  late final TextEditingController _symmetryWorst;

  List<Object> _readingsList = [];
  String _response = '';

  @override
  void initState() {
    super.initState();
    _diseaseModel = DiseaseModelServices();
    _db = DatabaseServices();
    _radiusMean = TextEditingController();
    _areaMean = TextEditingController();
    _concavityMean = TextEditingController();
    _textureMean = TextEditingController();
    _smoothnessMean = TextEditingController();
    _concavePointsMean = TextEditingController();
    _perimeterMean = TextEditingController();
    _compactnessMean = TextEditingController();
    _symmetryMean = TextEditingController();
    _fractalDimensionMean = TextEditingController();
    _perimeterSE = TextEditingController();
    _compactnessSE = TextEditingController();
    _radiusSE = TextEditingController();
    _areaSE = TextEditingController();
    _concavitySE = TextEditingController();
    _textureSE = TextEditingController();
    _smoothnessSE = TextEditingController();
    _concavePointsSE = TextEditingController();
    _symmetrySE = TextEditingController();
    _radiusWorst = TextEditingController();
    _areaWorst = TextEditingController();
    _fractalDimensionSE = TextEditingController();
    _textureWorst = TextEditingController();
    _smoothnessWorst = TextEditingController();
    _concavityWorst = TextEditingController();
    _perimeterWorst = TextEditingController();
    _compactnessWorst = TextEditingController();
    _concavePointsWorst = TextEditingController();
    _fractalDimensionWorst = TextEditingController();
    _symmetryWorst = TextEditingController();
  }

  @override
  void dispose() {
    _radiusMean.dispose();
    _areaMean.dispose();
    _concavityMean.dispose();
    _textureMean.dispose();
    _smoothnessMean.dispose();
    _concavePointsMean.dispose();
    _perimeterMean.dispose();
    _compactnessMean.dispose();
    _symmetryMean.dispose();
    _fractalDimensionMean.dispose();
    _perimeterSE.dispose();
    _compactnessSE.dispose();
    _radiusSE.dispose();
    _areaSE.dispose();
    _concavitySE.dispose();
    _textureSE.dispose();
    _smoothnessSE.dispose();
    _concavePointsSE.dispose();
    _symmetrySE.dispose();
    _radiusWorst.dispose();
    _areaWorst.dispose();
    _fractalDimensionSE.dispose();
    _textureWorst.dispose();
    _smoothnessWorst.dispose();
    _concavityWorst.dispose();
    _perimeterWorst.dispose();
    _compactnessWorst.dispose();
    _concavePointsWorst.dispose();
    _fractalDimensionWorst.dispose();
    _symmetryWorst.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breast Cancer'),
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
                  // Radius Mean Field...
                  TextFormField(
                    controller: _radiusMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Radius Mean'),
                  ),

                  // Area Mean Field...
                  TextFormField(
                    controller: _areaMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Area Mean'),
                  ),

                  // Concavity Mean Field...
                  TextFormField(
                    controller: _concavityMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Concavity Mean'),
                  ),

                  // Texture Mean Field...
                  TextFormField(
                    controller: _textureMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Texture Mean'),
                  ),

                  // Smoothness Mean Field...
                  TextFormField(
                    controller: _smoothnessMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Smoothness Mean'),
                  ),

                  // Concave Points Mean Field...
                  TextFormField(
                    controller: _concavePointsMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Concave Points Mean'),
                  ),

                  // Perimeter Mean Field...
                  TextFormField(
                    controller: _perimeterMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Perimeter Mean'),
                  ),

                  // Compactness Mean Field...
                  TextFormField(
                    controller: _compactnessMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Compactness Mean'),
                  ),

                  // Symmetry Mean Field...
                  TextFormField(
                    controller: _symmetryMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Symmetry Mean'),
                  ),

                  // Fractal Dimension Mean Field...
                  TextFormField(
                    controller: _fractalDimensionMean,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration:
                        _decoration(labelText: 'Fractal Dimension Mean'),
                  ),

                  // Perimeter SE Field...
                  TextFormField(
                    controller: _perimeterSE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Perimeter SE'),
                  ),

                  // Compactness SE Field...
                  TextFormField(
                    controller: _compactnessSE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Compactness SE'),
                  ),

                  // Radius SE Field...
                  TextFormField(
                    controller: _radiusSE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Radius SE'),
                  ),

                  // Area SE Field...
                  TextFormField(
                    controller: _areaSE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Area SE'),
                  ),

                  // Concavity Se Field...
                  TextFormField(
                    controller: _concavitySE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Concavity SE'),
                  ),

                  // Texture SE Field...
                  TextFormField(
                    controller: _textureSE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Texture SE'),
                  ),

                  // Smoothness SE Field...
                  TextFormField(
                    controller: _smoothnessSE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Smoothness SE'),
                  ),

                  // Concave Points SE Field...
                  TextFormField(
                    controller: _concavePointsSE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Concave Points SE'),
                  ),

                  // Symmetry SE Field...
                  TextFormField(
                    controller: _symmetrySE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Symmetry SE'),
                  ),

                  // Radius Worst Field...
                  TextFormField(
                    controller: _radiusWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Radius Worst'),
                  ),

                  // Area Worst Field...
                  TextFormField(
                    controller: _areaWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Area Worst'),
                  ),

                  // Fractal Dimension SE Field...
                  TextFormField(
                    controller: _fractalDimensionSE,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Fractal Dimension SE'),
                  ),

                  // Texture Worst Field...
                  TextFormField(
                    controller: _textureWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Texture Worst'),
                  ),

                  // Smoothness Worst Field...
                  TextFormField(
                    controller: _smoothnessWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Smoothness Worst'),
                  ),

                  // Concavity Worst Field...
                  TextFormField(
                    controller: _concavityWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Concavity Worst'),
                  ),

                  // Perimeter Worst Field...
                  TextFormField(
                    controller: _perimeterWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Perimeter Worst'),
                  ),

                  // Compactness Worst Field...
                  TextFormField(
                    controller: _compactnessWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Compactness Worst'),
                  ),

                  // Concave Points Worst Field...
                  TextFormField(
                    controller: _concavePointsWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Concave Points Worst'),
                  ),

                  // Fractal Dimension Worst Field...
                  TextFormField(
                    controller: _fractalDimensionWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration:
                        _decoration(labelText: 'Fractal Dimension Worst'),
                  ),

                  // Symmetry Worst Field...
                  TextFormField(
                    controller: _symmetryWorst,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    validator: _validateForm,
                    decoration: _decoration(labelText: 'Symmetry Worst'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            PrimaryButton(
              text: 'Breast Cancer Prediction',
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
          double.parse(_radiusMean.text),
          double.parse(_areaMean.text),
          double.parse(_concavityMean.text),
          double.parse(_textureMean.text),
          double.parse(_smoothnessMean.text),
          double.parse(_concavePointsMean.text),
          double.parse(_perimeterMean.text),
          double.parse(_compactnessMean.text),
          double.parse(_symmetryMean.text),
          double.parse(_fractalDimensionMean.text),
          double.parse(_perimeterSE.text),
          double.parse(_compactnessSE.text),
          double.parse(_radiusSE.text),
          double.parse(_areaSE.text),
          double.parse(_concavitySE.text),
          double.parse(_textureSE.text),
          double.parse(_smoothnessSE.text),
          double.parse(_concavePointsSE.text),
          double.parse(_symmetrySE.text),
          double.parse(_radiusWorst.text),
          double.parse(_areaWorst.text),
          double.parse(_fractalDimensionSE.text),
          double.parse(_textureWorst.text),
          double.parse(_smoothnessWorst.text),
          double.parse(_concavityWorst.text),
          double.parse(_perimeterWorst.text),
          double.parse(_compactnessWorst.text),
          double.parse(_concavePointsWorst.text),
          double.parse(_fractalDimensionWorst.text),
          double.parse(_symmetryWorst.text),
        ];
      });

      final Map<String, List<Object>> readings = {
        'readings': _readingsList,
      };

      try {
        // Fetching the predictions...
        await _diseaseModel
            .fetchBreastCancerPredictions(readings)
            .then((response) async {
          setState(() => _response = response);
          if (context.mounted) {
            await showBreastCancerPredictionDialog(
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
                      'disease': 'Breast Cancer',
                      'prediction': _response,
                      'readings': <String, Object>{
                        'radius-mean': _readingsList[0],
                        'area-mean': _readingsList[1],
                        'concavity-mean': _readingsList[2],
                        'texture-mean': _readingsList[3],
                        'smoothness-mean': _readingsList[4],
                        'concave-points-mean': _readingsList[5],
                        'perimeter-mean': _readingsList[6],
                        'compactness-mean': _readingsList[7],
                        'symmetry-mean': _readingsList[8],
                        'fractal-dimension-mean': _readingsList[9],
                        'perimeter-se': _readingsList[10],
                        'compactness-se': _readingsList[11],
                        'radius-se': _readingsList[12],
                        'area-se': _readingsList[13],
                        'concavity-se': _readingsList[14],
                        'texture-se': _readingsList[15],
                        'smoothness-se': _readingsList[16],
                        'concave-points-se': _readingsList[17],
                        'symmetry-se': _readingsList[18],
                        'radius-worst': _readingsList[19],
                        'area-worst': _readingsList[20],
                        'fractal-dimension-se': _readingsList[21],
                        'texture-worst': _readingsList[22],
                        'smoothness-worst': _readingsList[23],
                        'concavity-worst': _readingsList[24],
                        'perimeter-worst': _readingsList[25],
                        'compactness-worst': _readingsList[26],
                        'concave-points-worst': _readingsList[27],
                        'fractal-dimension-worst': _readingsList[28],
                        'symmetry-worst': _readingsList[29],
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
