import 'package:chc_design/detail_kucing.dart';
import 'package:chc_design/service/service_firestoreage.dart';
import 'package:chc_design/tambah_kucing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mycatscreeb extends StatefulWidget {
  @override
  _MycatscreebState createState() => _MycatscreebState();
}

class _MycatscreebState extends State<Mycatscreeb> {
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.grey[350],
        title: Text(
          'My Cat',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<DocumentSnapshot>(
              future: Servicefstore.getUser(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sayangi Dirimu Seperti Kamu Menyayangi Kucingmu',
                          style: TextStyle(color: Colors.orange[700]),
                        ),
                      ),
                    ),
                    Divider(),
                    
                         Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 40),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                           child: snapshot.data.data()["profile"] != null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill, 
                                      image: NetworkImage(
                                        snapshot.data.data()["profile"],
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text(
                          snapshot.data.data()["username"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(snapshot.data.data()["email"]),
                    ),
                  ],
                );
              }),
            SizedBox(
              height: 10,
            ),
          StreamBuilder<QuerySnapshot>(
              stream: Servicefstore.getMycat(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.docs.length + 1,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Addcatscreen()));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Icon(Icons.add),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Tambahkan Kucing'),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contex) => Detailkucing(id:snapshot.data.docs[index - 1].id),
                                    ));
                              },
                              child: Column(
                                children: [
                                  Container(
                                      height: 70,
                                      width: 70,
                                      margin: EdgeInsets.only(right: 10 ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                      ),
                                      child: snapshot.data.docs[index - 1]
                                                      .data()['gambar'] ==
                                                  null ||
                                              snapshot.data.docs[index - 1]
                                                      .data()['gambar'] ==
                                                  ''
                                          ? Icon(
                                              Icons.person,
                                              size: 40,
                                              color: Colors.grey[400],
                                            )
                                          : Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    snapshot
                                                        .data.docs[index - 1]
                                                        .data()['gambar'],
                                                  ),
                                                ),
                                              ),
                                            )),
                                  SizedBox(height: 5),
                                  Text(snapshot.data.docs[index - 1]
                                      .data()['nama']),
                                ],
                              ),
                            );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
