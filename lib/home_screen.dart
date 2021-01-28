import 'package:chc_design/cat_shop_screen.dart';
import 'package:chc_design/mycat_screen.dart';
import 'package:chc_design/service/service_firestoreage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chc_design/thread.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var listThread = [
    CHCToday(
      threadStarter: 'iskrim',
      subForum: 'Healthy Cat',
      judulThread: 'Obat-Obatan Alami yang Ampuh untuk Kucing Diare',
      view: 666,
      comment: 20,
      imageUrl:
          'https://infobinatang.com/wp-content/uploads/2019/08/cropped-keracunan-pada-kucing.jpg',
    ),
    CHCToday(
      threadStarter: 'iskrim',
      subForum: 'Accessoris ',
      judulThread: 'Jenis-Jenis Kalung Kucing',
      view: 70,
      comment: 200,
      imageUrl:
          'https://infobinatang.com/wp-content/uploads/2019/08/cropped-keracunan-pada-kucing.jpg',
    ),
    CHCToday(
      threadStarter: 'iskrim',
      subForum: 'Healthy Cat',
      judulThread: 'Steril Mengancam Kucing Kita?',
      view: 666,
      comment: 20,
      imageUrl:
          'https://infobinatang.com/wp-content/uploads/2019/08/cropped-keracunan-pada-kucing.jpg',
    ),
    CHCToday(
      threadStarter: 'iskrim',
      subForum: 'Tips and Trick Care Cat',
      judulThread: 'Tips untuk Kucing yang Bandel Di Rumah',
      view: 666,
      comment: 20,
      imageUrl:
          'https://infobinatang.com/wp-content/uploads/2019/08/cropped-keracunan-pada-kucing.jpg',
    ),
    CHCToday(
      threadStarter: 'iskrim',
      subForum: 'Accessoris',
      judulThread: 'Baju-Baju untuk Kucing',
      view: 666,
      comment: 20,
      imageUrl:
          'https://infobinatang.com/wp-content/uploads/2019/08/cropped-keracunan-pada-kucing.jpg',
    ),
  ];
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
              Container(
                margin: EdgeInsets.all(20),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder<DocumentSnapshot>(
                  future: Servicefstore.getUser(user.uid),
                  builder: (ctx, value) {
                    if (value.hasData) {
                      return Text(
                        value.data.data()['username'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      );
                    }
                    return Text(
                      "username",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    );
                  },
                ),
              ),
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
      body: ListView.builder(
        itemCount: listThread.length,
        itemBuilder: (context, index) {
          return Container(
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
                      Text(listThread[index].threadStarter,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Text(listThread[index].subForum,
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
                  child: Text(listThread[index].judulThread,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 280,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(listThread[index].imageUrl),
                  ),
                ),
                Container(
                  height: 30,
                  child: Row(
                    children: [
                      Icon(Icons.remove_red_eye),
                      Text(listThread[index].view.toString()),
                      SizedBox(width: 10),
                      Icon(Icons.message),
                      Text(listThread[index].comment.toString()),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
