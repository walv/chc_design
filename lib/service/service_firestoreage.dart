import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Servicefstore{
  static var user = FirebaseFirestore.instance.collection('user');

  static Future<void> addUser(String id, String username, String email) async{
    user.doc(id).set({
      "username":username,
      "email":email,
    });
  }
  static Future<DocumentSnapshot> getUser(String id) async{
    return await user.doc(id).get();
  }

  static var thread = FirebaseFirestore.instance.collection('thread');

  static Stream<QuerySnapshot> getThread(){
    return thread.limit(15).orderBy('date_time').get().asStream();
  }
}