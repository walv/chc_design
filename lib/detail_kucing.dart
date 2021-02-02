import 'package:chc_design/service/service_firestoreage.dart';
import 'package:chc_design/tambah_kucing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Detailkucing extends StatefulWidget {
  final String id;

  const Detailkucing({Key key, this.id}) : super(key: key);

  @override
  _DetailkucingState createState() => _DetailkucingState();
}

class _DetailkucingState extends State<Detailkucing> {
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.grey[350],
        title: Text(
          'Your Cat',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: Servicefstore.getKucing(user.uid, widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Sayangi Kucingmu seperti menyayangi dirimu',
                        style: TextStyle(color: Colors.orange[500]),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            child: snapshot.data.data()['gambar'] == null ||
                                    snapshot.data.data()['gambar'] == ''
                                ? Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.grey[400],
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          snapshot.data.data()['gambar'],
                                        ),
                                      ),
                                    ),
                                  )),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        snapshot.data.data()['nama'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        snapshot.data.data()['jenis '],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        snapshot.data.data()['kelamin'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  //   child: Text('Umur ${snapshot.data.data()['umur']}'),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  //   child: Text('Berat ${snapshot.data.data()['berat_badan']}'),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        child: OutlineButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Addcatscreen(id:widget.id,
                                        gambar:snapshot.data.data()['gambar'],
                                        nama:snapshot.data.data()['nama'],
                                        jenis :snapshot.data.data()['jenis '],
                                        kelamin:snapshot.data.data()['kelamin'],
                                        umur:snapshot.data.data()['umur'].toString(),
                                        berat_badan:snapshot.data.data()['berat_badan'].toString(),
                                        )));
                                        setState(() {
                                          
                                        });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
