import 'dart:convert';

import 'package:http/http.dart' as http;

class DiseaseModel {
  // Api key...
  final _apiKey = 'http://192.168.1.9:5000';

  // Fetching the symptoms list...
  Future<Map<String, dynamic>> fetchSymptomList() async {
    final response =
        await http.get(Uri.parse('$_apiKey/retrieve_symptoms_list'));

    if (response.statusCode == 200) {
      final data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } else {
      throw Exception('Failed to load the symptom list.');
    }
  }

  // Fetching the General Disease results...
  Future<Map<String, dynamic>> fetchGeneralDiseasePredictions(
      Map<String, List<String>> symptoms) async {
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
      throw Exception('Unable to retrieve predictions.');
    }
  }
}
