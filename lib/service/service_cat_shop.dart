import 'package:chc_design/model/cat_shop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceCatShop {
  static var _catShop = FirebaseFirestore.instance.collection('catShop');

  static Future<List<CatShopModel>> getCatShop() async {
    var result = await _catShop.get();

    var catShopList = result.docs;
    return catShopList
        .map((catShop) => CatShopModel.fromJSON(catShop.id, catShop.data()))
        .toList();
  }
}
