import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/auth_service.dart';

final _firestore = FirebaseFirestore.instance;

class DatabaseServices {
  final docId = AuthService.firebase().currentUser!.id;

  late final DocumentReference _userDataDocumentRef;
  late final DocumentReference _basicInformationDocumentRef;
  late final DocumentReference _additionalInformationDocumentRef;

  DatabaseServices() {
    _userDataDocumentRef = _firestore.collection('user-data').doc(docId);

    _basicInformationDocumentRef =
        _userDataDocumentRef.collection('basic-information').doc(docId);

    _additionalInformationDocumentRef =
        _userDataDocumentRef.collection('additional-information').doc(docId);
  }

  // Setting Username and Gender to main collection (user-data)...
  Future setUserData(String username, String gender) async {
    _userDataDocumentRef.set({
      'username': username,
      'gender': gender,
    });
  }

  // Setting Age to the sub collection (basic-information)...
  Future setBasicInformation(Map<String, Object?> data) async {
    _basicInformationDocumentRef.set(data);
  }

  // Updating the existing data in (basic-information) document...
  Future updateBasicInformation(Map<String, Object?> data) async {
    _basicInformationDocumentRef.update(data);
  }

  // Setting up an empty (additional-information) document...
  Future setAdditionalInformation(Map<String, Object?> data) async {
    _additionalInformationDocumentRef.set(data);
  }

  // Updating the existing data in (additional-information) document...
  Future updateAdditionalInformation(Map<String, Object?> data) async {
    _additionalInformationDocumentRef.update(data);
  }
}
