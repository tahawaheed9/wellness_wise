import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/auth_service.dart';

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;
  final docId = AuthService.firebase().currentUser!.id;

  late final bool isDataSaved;

  late final DocumentReference _userDataDocumentRef;
  late final CollectionReference _additionalInformationCollectionRef;

  // Initializing the Document & Collection References...
  DatabaseServices() {
    _userDataDocumentRef = _firestore.collection('user-data').doc(docId);

    _additionalInformationCollectionRef =
        _userDataDocumentRef.collection('additional-information');
  }

  // Setting Username and Gender to main collection (user-data)...
  Future setUserData(
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
      return error.toString();
    }
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
