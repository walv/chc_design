import 'dart:io';

import 'package:chc_design/service/service_firestoreage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  String image;
  String nama;
  String deskripsi;
  Edit({
    this.image,
    this.nama,
    this.deskripsi,
  });

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  var namaController = TextEditingController();
  var deskripsiController = TextEditingController();
  User user;
  File image;
  String img;
  final picker = ImagePicker();

  @override
  void initState() {
    namaController.text = widget.nama ?? "";
    deskripsiController.text = widget.deskripsi ?? "";
    img = widget.image??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              var data = {
                'nama': namaController.text,
                'deskripsi': deskripsiController.text,
              };

              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('Profile Changed'),
                    content: Text('Do you want to save your edits?'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('Save'),
                        onPressed: () async {
                          String filename;
                          String downloadurl = widget.image;
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
                          }

                          await Servicefstore.updateProfile(
                            user.uid,
                            namaController.text,
                            deskripsiController.text,
                            downloadurl ?? "",
                          );
                          //close dialog
                          Navigator.pop(context);
                          //close page
                          Navigator.pop(context, data);
                        },
                      )
                    ],
                  );
                },
              );
            },
            child: Icon(
              Icons.check,
              color: Colors.blue,
            ),
          )
        ],
        backgroundColor: Colors.grey[350],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    if (img != null&&img!='')
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: 
                                  NetworkImage(widget.image),
                                  
                              fit: BoxFit.contain),
                        ),
                      ),
                    if (image != null)
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:FileImage(image),
                              fit: BoxFit.contain),
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () async {
                          await choiceImage(context);
                          if (image != null) {
                            img = null;
                          }
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.edit),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Provide your personal information.This will not be a part of your public profile ',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              )
            ],
          ),
        ),
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
