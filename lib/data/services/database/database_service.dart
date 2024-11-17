import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../auth/auth_service.dart';

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;
  final _docId = AuthService.firebase().currentUser!.id;

  late final DocumentReference _userDataDocumentRef;
  late final CollectionReference _predictionCollectionRef;
  late final CollectionReference _notificationCollectionRef;

  // Initializing the Document & Collection References...
  DatabaseServices() {
    _userDataDocumentRef = _firestore.collection('user-data').doc(_docId);

    _predictionCollectionRef = _userDataDocumentRef.collection('predictions');

    _notificationCollectionRef =
        _userDataDocumentRef.collection('notifications');
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

  // Fetching the user data...
  Future<Map<String, dynamic>> fetchUserData() async {
    late final Map<String, dynamic> data;

    try {
      final DocumentSnapshot documentSnapshot =
          await _userDataDocumentRef.get();

      if (documentSnapshot.exists) {
        data = documentSnapshot.data()! as Map<String, dynamic>;
      }
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Unable to fetch the user data.');
    }
    return data;
  }

  // Adding new predictions to the 'predictions' collection...
  Future<void> addPrediction(Map<String, Object?> data) async {
    try {
      await _predictionCollectionRef.add(data);
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Unable to save the predicted data.');
    }
  }

  // Fetch Prediction data...
  Future<Map<String, dynamic>> fetchPredictionData(String docId) async {
    late final Map<String, dynamic> data;
    try {
      final DocumentSnapshot documentSnapshot =
          await _predictionCollectionRef.doc(docId).get();

      if (documentSnapshot.exists) {
        data = documentSnapshot.data()! as Map<String, dynamic>;
      }
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Unable to fetch the data.');
    }
    return data;
  }

  // Deleting a prediction...
  Future<void> deletePrediction(String docId) async {
    try {
      await _predictionCollectionRef.doc(docId).delete();
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Unable to delete the prediction.');
    }
  }

  // Adding notifications to the 'notifications' collection...
  Future<void> addNotification(Map<String, Object> data) async {
    try {
      await _notificationCollectionRef.add(data);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // Deleting a notification...
  Future<void> deleteNotification(String docId) async {
    try {
      await _notificationCollectionRef.doc(docId).delete();
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Unable to delete the notification.');
    }
  }
}
