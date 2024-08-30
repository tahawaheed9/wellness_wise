import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/auth_service.dart';

final _firestore = FirebaseFirestore.instance;

class DatabaseServices {
  final docId = AuthService.firebase().currentUser!.id;

  late final DocumentReference _userDataDocumentRef;
  late final CollectionReference _basicInformationCollectionRef;
  late final CollectionReference _additionalInformationCollectionRef;

  DatabaseServices() {
    _userDataDocumentRef = _firestore.collection('user-data').doc(docId);

    _basicInformationCollectionRef =
        _userDataDocumentRef.collection('basic-information');

    _additionalInformationCollectionRef =
        _userDataDocumentRef.collection('additional-information');
  }

  // Setting Username and Gender to main collection (user-data)...
  Future setUserData(String username, String gender, DateTime createdOn) async {
    await _userDataDocumentRef.set({
      'username': username,
      'gender': gender,
      'created-on': createdOn,
    });
  }

  // Adding new document to the 'basic-information' collection...
  Future addBasicInformation(Map<String, Object?> data) async {
    await _basicInformationCollectionRef.add(data);
  }

  // Adding new document to the 'additional-information' collection...
  Future addAdditionalInformation(Map<String, Object?> data) async {
    await _additionalInformationCollectionRef.add(data);
  }
}
