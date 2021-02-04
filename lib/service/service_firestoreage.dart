import 'package:cloud_firestore/cloud_firestore.dart';

class Servicefstore {
  static var user = FirebaseFirestore.instance.collection('user');

  static Future<void> addUser(String id, String username, String email) async {
    user.doc(id).set({
      "username": username,
      "email": email,
    });
  }
  static Future<void> updateProfile(String id, String nama, String deskripsi, String profile) async {
    await user.doc(id).set({
      "profile": profile,
      "nama": nama,
      "deskripsi" : deskripsi,

    }, SetOptions(merge: true));
  }

  static Future<DocumentSnapshot> getUser(String id) async {
    return await user.doc(id).get();
  }
  
  static Stream<QuerySnapshot> getMycat(String id)  {
    return  user.doc(id).collection('mycat').snapshots();
  
  }
  static Stream<DocumentSnapshot> getKucing(String uid, String id)  {
    return  user.doc(uid).collection('mycat').doc(id).snapshots();
  }

static Future<void> editCat({String uid, String id,String nama, String gambar, String jenis, String kelamin , int umur , int beratbadan}){
    return user.doc(uid).collection('mycat').doc(id).set({
      "nama" : nama,
      "gambar" : gambar,
      "jenis " : jenis,
      "kelamin" : kelamin,
      "umur" : umur,
      "berat_badan" : beratbadan,
        
    });
  }

  static Future<void> delCat({String uid, String id}){
    return user.doc(uid).collection('mycat').doc(id).delete();
  }

  static Future<void> addMycat({String id, String nama, String gambar, String jenis, String kelamin , int umur , int beratbadan}){
    return user.doc(id).collection('mycat').doc().set({
      "nama" : nama,
      "gambar" : gambar,
      "jenis " : jenis,
      "kelamin" : kelamin,
      "umur" : umur,
      "list_gambar" : [],
      "berat_badan" : beratbadan,
      
    });
  }
  static Future<void> addImageCat({String uid, String id, List<dynamic> list_gambar}){
    return user.doc(uid).collection('mycat').doc(id).set({
      "list_gambar" : [
        ...list_gambar,
      ],
      
    },SetOptions(merge: true));
  }
}
