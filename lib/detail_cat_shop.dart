import 'package:chc_design/cat_shop_screen.dart';
import 'package:chc_design/confirm_shop_screen.dart';
import 'package:chc_design/model/cat_shop_model.dart';
import 'package:flutter/material.dart';

class DetailCatShop extends StatefulWidget {
  final CatShopModel catShopModel;

  const DetailCatShop({Key key, this.catShopModel}) : super(key: key);

  @override
  _DetailCatShopState createState() => _DetailCatShopState();
}

class _DetailCatShopState extends State<DetailCatShop> {
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
          "Cat Shop Detail",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        widget.catShopModel.image,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 10,
                  ),
                  child: Text(
                    widget.catShopModel.namaBarang,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 10,
                  ),
                  child: Row(
                    children: [
                      ...List.generate(5, (id) {
                        return Icon(
                          Icons.star,
                          size: 15,
                          color: (id < widget.catShopModel.rating)
                              ? Colors.yellow
                              : Colors.grey,
                        );
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    "Rp. ${widget.catShopModel.harga}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 10,
                  ),
                  child: Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 10,
                  ),
                  child: Text(
                    "${widget.catShopModel.desc}",
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Pesan",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmShopScreen(
                              linkShopee: widget.catShopModel.linkShopee)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
