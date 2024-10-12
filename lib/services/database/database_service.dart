import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../auth/auth_service.dart';

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;
  final _docId = AuthService.firebase().currentUser!.id;

  late final DocumentReference _userDataDocumentRef;
  late final CollectionReference _predictionCollectionRef;

  // Initializing the Document & Collection References...
  DatabaseServices() {
    _userDataDocumentRef = _firestore.collection('user-data').doc(_docId);

    _predictionCollectionRef = _userDataDocumentRef.collection('predictions');
  }

  // Setting Username and Gender to main collection (user-data)...
  Future<void> setUserData(
    String username,
    DateTime dateOfBirth,
    String gender,
    DateTime createdOn,
  ) async {
    try {
      await _userDataDocumentRef.set({
        'username': username,
        'date-of-birth': dateOfBirth,
        'gender': gender,
        'created-on': createdOn,
      });
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Unable to save the information.');
    }
  }

  // Adding new predictions to the 'predictions' collection..
  Future<void> addPrediction(Map<String, Object?> data) async {
    try {
      await _predictionCollectionRef.add(data);
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Unable to save the prediction.');
    }
  }

  Future<void> deletePrediction(String docId) async {
    try {
      await _predictionCollectionRef.doc(docId).delete();
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Unable to delete the record.');
    }
  }
}
