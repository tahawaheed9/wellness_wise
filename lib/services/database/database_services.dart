import 'package:cloud_firestore/cloud_firestore.dart';

// Instance for the cloud firestore...
final dbInstance = FirebaseFirestore.instance;

// Getting the reference for the collection 'user-data'...
final userDataRef = dbInstance.collection('user-data');


// Getting the reference of the document...
final dbRef = userDataRef.doc();

final nestedDBRef = dbRef.collection('basic-information');

// Allows you to add user's information to the cloud...
Future addUserData(Map<String, Object?> userInfo) async {
  await userDataRef.doc().set(userInfo);
}

// Set Age to Basic Information Collection
Future addAge(Map<String, Object?> age) async {
  await nestedDBRef.add(age);
}

// Creates a nested collection of basic-information and saves
// basic information there...
Future addBasicInformation(Map<String, Object?> basicInformation) async {
  await nestedDBRef.add(basicInformation);
}
