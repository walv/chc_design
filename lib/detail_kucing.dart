import 'dart:ffi';
import 'dart:io';

import 'package:chc_design/service/service_firestoreage.dart';
import 'package:chc_design/tambah_kucing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class Detailkucing extends StatefulWidget {
  final String id;

  const Detailkucing({Key key, this.id}) : super(key: key);

  @override
  _DetailkucingState createState() => _DetailkucingState();
}

class _DetailkucingState extends State<Detailkucing> {
  User user;
  String id;
  File image;
  List<dynamic> list_gambar;
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
      body: StreamBuilder<DocumentSnapshot>(
          stream: Servicefstore.getKucing(user.uid, widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            list_gambar = snapshot.data.data()['list_gambar'];
            id = snapshot.data.id;
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
                      child: Text("Identitas Kucing ",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        "Nama: ${snapshot.data.data()['nama']}",
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        "Jenis Kucing: ${snapshot.data.data()['jenis ']}",
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        "Jenis KElamin Kucing : ${snapshot.data.data()['kelamin']}",
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child:
                        Text('Umur Kucing : ${snapshot.data.data()['umur']}'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                        'Berat Badan kucing : ${snapshot.data.data()['berat_badan']}'),
                  ),
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
                                    builder: (context) => Addcatscreen(
                                          id: widget.id,
                                          gambar:
                                              snapshot.data.data()['gambar'],
                                          nama: snapshot.data.data()['nama'],
                                          jenis: snapshot.data.data()['jenis '],
                                          kelamin:
                                              snapshot.data.data()['kelamin'],
                                          umur: snapshot.data
                                              .data()['umur']
                                              .toString(),
                                          berat_badan: snapshot.data
                                              .data()['berat_badan']
                                              .toString(),
                                        )));
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      ...List.generate(
                        (snapshot.data.data()['list_gambar'] as List).length,
                        (index) => FullScreenWidget(
                          child: Container(
                            height:
                                (MediaQuery.of(context).size.width - 30) / 3,
                            width: (MediaQuery.of(context).size.width - 30) / 3,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  snapshot.data.data()['list_gambar'][index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await choiceImage(context);

          String filename;
          String downloadurl;
          if (image != null) {
            filename = basename(image.path);
            downloadurl = await FirebaseStorage.instance
                .ref()
                .child(filename)
                .putFile(image)
                .whenComplete(() {})
                .then(
              (task) async {
                return await task.ref.getDownloadURL();
              },
            );
            image = null;
            list_gambar.add(downloadurl);
            await Servicefstore.addImageCat(
              uid: user.uid,
              id: id,
              list_gambar: list_gambar,
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  imgFromCamera() async {
    var res = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    if (res != null) {
      File file = File(res.path);
      setState(() {
        image = file;
      });
    }
  }

  imgFromGallery() async {
    var res = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    if (res != null) {
      File file = File(res.path);
      setState(() {
        image = file;
      });
    }
  }

  Future<void> choiceImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
