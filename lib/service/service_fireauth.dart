import 'package:chc_design/service/service_firestoreage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Servicefauth {
  static var auth = FirebaseAuth.instance;

  static Future<String> login(String email, String password) async {
    try {
    var result = await auth.signInWithEmailAndPassword(email: email, password: password);
    return "Login Berhasil";
    } on FirebaseAuthException catch (e) {
        return e.message;
    }

  }

  static Future<String> daftar(String username, String email, String password) async {
    try {
    var result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    await Servicefstore.addUser(result.user.uid, username, email);
    return "Register Berhasil";
    } on FirebaseAuthException catch (e) {
        return e.message;
    }
  }

  static Future<String> logout() async {
    try {
    await auth.signOut();
    return "Signout Berhasil";
    } on FirebaseAuthException catch (e) {
        return e.message;
    }
  }


  static Stream<User> currentUser() => auth.authStateChanges();

}