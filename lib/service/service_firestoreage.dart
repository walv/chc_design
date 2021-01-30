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
  
  static Stream<QuerySnapshot> getMycat(String id)  {
    return  user.doc(id).collection('mycat').snapshots();
  
  }

  static Future<void> addMycat({String id, String nama, String gambar, String jenis, String kelamin , int umur , int beratbadan}){
    return user.doc(id).collection('mycat').doc().set({
      "nama" : nama,
      "gambar" : gambar,
      "jenis " : jenis,
      "kelamin" : kelamin,
      "umur" : umur,
      "berat_badan" : beratbadan,
      
    });
  }
}
