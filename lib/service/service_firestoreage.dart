import 'package:cloud_firestore/cloud_firestore.dart';

class Servicefstore {
  static var user = FirebaseFirestore.instance.collection('user');

  static Future<void> addUser(String id, String username, String email) async {
    user.doc(id).set({
      "username": username,
      "email": email,
    });
  }

  static Future<DocumentSnapshot> getUser(String id) async {
    return await user.doc(id).get();
  }
}
