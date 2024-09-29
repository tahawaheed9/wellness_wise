import 'dart:convert';

import 'package:http/http.dart' as http;

class DiseaseModelServices {
  // Api key...
  /// Android Studio maps 127.0.0.1 (localhost) -> 10.0.2.2
  final _apiKey = 'http://10.0.2.2:5000';

  // Fetching the symptoms list...
  Future<List<dynamic>> fetchSymptomList() async {
    try {
      final response =
          await http.get(Uri.parse('$_apiKey/retrieve_symptoms_list'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<dynamic> symptomList = data['symptoms'];
        return symptomList;
      } else {
        throw Exception(
            'Unable to fetch the list. Status code: ${response.statusCode}.');
      }
    } catch (_) {
      throw Exception(
          'Please, check your internet connection or contact support.');
    }
  }

  // Fetching the General Disease results...
  Future<Map<String, dynamic>> fetchGeneralDiseasePredictions(
      Map<String, List<String>> symptoms) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiKey/general_disease_prediction'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(symptoms),
      );

      // If API is active, retrieve general disease predictions...
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data;
      } else {
        throw Exception(
            'Unable to retrieve predictions. Status code: ${response.statusCode}.');
      }
    } catch (_) {
      throw Exception(
          'Please, check your internet connection or contact support.');
    }
  }

  // Fetching the Heart Disease Predictions...
  Future<String> fetchHeartDiseasePredictions(
      Map<String, List<Object>> readings) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiKey/heart_failure_prediction'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(readings),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final message = data['response'];
        return message;
      } else {
        throw Exception(
            'Unable to retrieve predictions. Status code: ${response.statusCode}.');
      }
    } catch (_) {
      throw Exception(
          'Please, check your internet connection or contact support.');
    }
  }

  // Fetching the Diabetes Predictions...
  Future<String> fetchDiabetesPredictions(
      Map<String, List<Object>> readings) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiKey/diabetes_prediction'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(readings),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final message = data['response'];
        return message;
      } else {
        throw Exception(
            'Unable to retrieve predictions. Status code: ${response.statusCode}.');
      }
    } catch (_) {
      throw Exception(
          'Please, check your internet connection or contact support.');
    }
  }

  // Fetching Chronic Kidney Predictions...
  Future<String> fetchKidneyPredictions(
      Map<String, List<Object>> readings) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiKey/kidney_prediction'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(readings),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final message = data['response'];
        return message;
      } else {
        throw Exception(
            'Unable to retrieve predictions. Status code: ${response.statusCode}.');
      }
    } catch (_) {
      throw Exception(
          'Please, check your internet connection or contact support.');
    }
  }
}
