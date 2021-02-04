import 'dart:io';

import 'package:chc_design/service/service_firestoreage.dart';
import 'package:chc_design/service/service_forum_tanya.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:path/path.dart';

class Addcatscreen extends StatefulWidget {
  String id;
  String nama;
  String jenis;
  String kelamin;
  String umur;
  String berat_badan;
  String gambar;

  Addcatscreen(
      {this.id,
      this.nama,
      this.berat_badan,
      this.gambar,
      this.jenis,
      this.kelamin,
      this.umur});
  @override
  _AddcatscreenState createState() => _AddcatscreenState();
}

class _AddcatscreenState extends State<Addcatscreen> {
  var namaC = TextEditingController();
  var jenisC = TextEditingController();
  var kelaminC = TextEditingController();
  var umurC = TextEditingController();
  var beratbadanC = TextEditingController();
  User user;
  File image;
  String img;

  @override
  void initState() {
    namaC.text = widget.nama ?? '';
    jenisC.text = widget.jenis ?? '';
    kelaminC.text = widget.kelamin ?? '';
    umurC.text = widget.umur ?? '';
    beratbadanC.text = widget.berat_badan ?? '';
    img = widget.gambar ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Data Kucing',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  if (img != null && img != '')
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(widget.gambar),
                            fit: BoxFit.contain),
                      ),
                    ),
                  if (image != null)
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(image), fit: BoxFit.contain),
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async {
                        await choiceImage(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: namaC,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Nama Kucing",hintText: 'Nama'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: jenisC,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Jenis Kucing",hintText: 'Jenis'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: kelaminC,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText:"Jenis Kelamin Kucing",hintText: 'Kelamin'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: umurC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Umur Kucing",hintText: 'Umur'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: beratbadanC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Berat Badan Kucing",hintText: 'Berat badan'),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 110,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  String filename;
                  String downloadurl = widget.gambar;
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
                  if (widget.id != null) {
                    await Servicefstore.editCat(
                      uid: user.uid,
                      id: widget.id,
                      nama: namaC.text,
                      gambar: downloadurl ?? '',
                      jenis: jenisC.text,
                      umur: int.parse(umurC.text),
                      kelamin: kelaminC.text,
                      beratbadan: int.parse(beratbadanC.text),
                    );
                  } else {
                    await Servicefstore.addMycat(
                      id: user.uid,
                      nama: namaC.text,
                      gambar: downloadurl ?? '',
                      jenis: jenisC.text,
                      umur: int.parse(umurC.text),
                      kelamin: kelaminC.text,
                      beratbadan: int.parse(beratbadanC.text),
                    );
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
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
