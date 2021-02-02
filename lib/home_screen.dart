import 'package:chc_design/cat_shop_screen.dart';
import 'package:chc_design/detail_berita.dart';
import 'package:chc_design/mycat_screen.dart';
import 'package:chc_design/service/service_berita.dart';
import 'package:chc_design/service/service_firestoreage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/berita_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.white,
        title: Container(
            height: 50,
            width: 150,
            child: Image(image: AssetImage('assets/judul.png'))),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<DocumentSnapshot>(
                  future: Servicefstore.getUser(user.uid),
                  builder: (ctx, value) {
                    if (!value.hasData) {
                      return Container(
                        height: 190,
                      );
                    } else {
                      return Column(
                        children: [
                         Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 40),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                           child: value.data.data()["profile"] != null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        value.data.data()["profile"],
                                      ),
                                    ),
                                  ),
                                )
                              :
                          Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                        ),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                value.data.data()['username'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              )),
                        ],
                      );
                    }
                  }),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contex) => Mycatscreeb(),
                      ));
                },
                leading: Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
                title: Text(
                  'My Cat',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CatShopScreen()));
                },
                leading: Icon(
                  Icons.food_bank,
                  color: Colors.black,
                ),
                title: Text(
                  'Accessoris & Kebutuhan Kucing',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'Pusat Bantuan',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Beritamodel>>(
          future: Serviceberita.getberita(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var listThread = snapshot.data;
            return ListView.builder(
              itemCount: listThread.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detailberitascreen(
                                  beritamodel: listThread[index],
                                )));
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    height: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          child: Row(
                            children: [
                              Text("Kategori",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              Text(listThread[index].kategori,
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height: 30,
                          child: Text(listThread[index].judul,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          height: 280,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(listThread[index].image),
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Row(
                            children: [
                              Icon(Icons.message),
                              Text(listThread[index].comment.length.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
