import 'package:chc_design/model/berita_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Serviceberita {
  static var berita = FirebaseFirestore.instance.collection('berita');

  static Future<List<Beritamodel>> getberita() async {
    var value = await berita.get();
    return value.docs.map((e) => Beritamodel.fromjson(e.data(),e.id)).toList();
  }
}
