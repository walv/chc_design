import 'package:chc_design/service/service_firestoreage.dart';
import 'package:chc_design/service/service_forum_tanya.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Addcatscreen extends StatefulWidget {
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
  
  @override
  Widget build(BuildContext context) {
    user= Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: namaC,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Nama'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: jenisC,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Jenis'),
              ),
            ),Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: kelaminC,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Kelamin'),
              ),
            ),Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: umurC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Umur'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: beratbadanC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Berat badan'),
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
                 await Servicefstore.addMycat(
                  id: user.uid,
                  nama: namaC.text,
                  gambar: '',
                  jenis: jenisC.text,
                  umur: int.parse(umurC.text),
                  kelamin: kelaminC.text,
                  beratbadan: int.parse(beratbadanC.text),

                 );
                 Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
