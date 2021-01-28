import 'package:chc_design/detail_cat_shop.dart';
import 'package:flutter/material.dart';

class CatShopModel {
  final String id;
  final String namaBarang;
  final String image;
  final double rating;
  final int harga;

  CatShopModel({this.image, this.id, this.namaBarang, this.rating, this.harga});
}

class CatShopScreen extends StatefulWidget {
  @override
  _CatShopScreenState createState() => _CatShopScreenState();
}

class _CatShopScreenState extends State<CatShopScreen> {
  var listShop = [
    CatShopModel(
      id: "1",
      namaBarang: "Wiskas",
      rating: 4,
      harga: 10000,
      image:
          "https://cdn.onemars.net/sites/whiskas_id_98_2/image/whiskas-sea-mackerel-1_1584084060104.png",
    ),
    CatShopModel(
      id: "1",
      namaBarang: "Kandang Kucing",
      rating: 4,
      harga: 14000,
      image:
          "https://i2.wp.com/tokoreklame.id/wp-content/uploads/2020/01/Kandang-Kucing.jpg?ssl=1",
    ),
    CatShopModel(
      id: "1",
      namaBarang: "Pasir Kucing",
      rating: 4,
      harga: 12000,
      image: "https://blogpictures.99.co/pasir-kucing.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Cat Shop",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: listShop.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailCatShop(catShopModel: listShop[index])));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            listShop[index].image,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 7,
                      ),
                      child: Text(
                        listShop[index].namaBarang,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 7,
                      ),
                      child: Row(
                        children: [
                          ...List.generate(5, (id) {
                            return Icon(
                              Icons.star,
                              size: 15,
                              color: (id < listShop[index].rating)
                                  ? Colors.yellow
                                  : Colors.grey,
                            );
                          }),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 7,
                          bottom: 10,
                        ),
                        child: Text(
                          "Rp. ${listShop[index].harga}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
