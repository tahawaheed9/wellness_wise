import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/auth_service.dart';

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;
  final docId = AuthService.firebase().currentUser!.id;

  late final bool isDataSaved;

  late final DocumentReference _userDataDocumentRef;
  late final CollectionReference _basicInformationCollectionRef;
  late final CollectionReference _additionalInformationCollectionRef;

  // Initializing the Document & Collection References...
  DatabaseServices() {
    _userDataDocumentRef = _firestore.collection('user-data').doc(docId);

    _basicInformationCollectionRef =
        _userDataDocumentRef.collection('basic-information');

    _additionalInformationCollectionRef =
        _userDataDocumentRef.collection('additional-information');
  }

  // Setting Username and Gender to main collection (user-data)...
  Future setUserData(
    String username,
    String gender,
    DateTime createdOn,
  ) async {
    try {
      await _userDataDocumentRef.set({
        'username': username,
        'gender': gender,
        'created-on': createdOn,
      });
    } catch (error) {
      return error.toString();
    }
  }

  // Adding new document to the 'basic-information' collection...
  Future<bool> addBasicInformation(Map<String, Object?> data) async {
    try {
      await _basicInformationCollectionRef
          .add(data)
          .whenComplete(<bool>() {
        isDataSaved = true;
      });
    } catch (_) {
      isDataSaved = false;
    }
    return isDataSaved;
  }

  // Adding new document to the 'additional-information' collection...
  Future<bool> addAdditionalInformation(Map<String, Object?> data) async {
    try {
      await _additionalInformationCollectionRef
          .add(data)
          .whenComplete(<bool>() {
        isDataSaved = true;
      });
    } catch (_) {
      isDataSaved = false;
    }
    return isDataSaved;
  }
}
