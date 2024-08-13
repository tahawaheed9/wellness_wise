import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;

class DatabaseServices {
  final docId = FirebaseAuth.instance.currentUser!.uid;

  late final DocumentReference _userDataDocumentRef;
  late final DocumentReference _basicInformationDocumentRef;

  DatabaseServices() {
    _userDataDocumentRef = _firestore.collection('user-data').doc(docId);
    _basicInformationDocumentRef =
        _userDataDocumentRef.collection('basic-information').doc(docId);
  }

  // Setting Username and Gender to main collection (user-data)...
  Future setUserData(String username, String gender) async {
    _userDataDocumentRef.set({
      'username': username,
      'gender': gender,
    });
  }

  // Setting Age to the sub collection (basic-information)...
  Future setBasicInformation(int age) async {
    _basicInformationDocumentRef.set({'age': age});
  }
}
