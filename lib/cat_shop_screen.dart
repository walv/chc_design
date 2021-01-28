import 'package:chc_design/detail_cat_shop.dart';
import 'package:chc_design/model/cat_shop_model.dart';
import 'package:chc_design/service/service_cat_shop.dart';
import 'package:flutter/material.dart';

class CatShopScreen extends StatefulWidget {
  @override
  _CatShopScreenState createState() => _CatShopScreenState();
}

class _CatShopScreenState extends State<CatShopScreen> {
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
      body: FutureBuilder<List<CatShopModel>>(
          future: ServiceCatShop.getCatShop(),
          builder: (context, value) {
            if (!value.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var listShop = value.data;
              return Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: listShop.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailCatShop(
                                    catShopModel: listShop[index])));
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
                            Container(
                              padding: const EdgeInsets.only(
                                left: 7,
                              ),
                              child: Text(
                                listShop[index].namaBarang,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
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
              );
            }
          }),
    );
  }
}
