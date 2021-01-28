import 'package:chc_design/service/service_forum_tanya.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class QuestScreen extends StatefulWidget {
  @override
  _QuestScreenState createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  var judulController = TextEditingController();
  var descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pertanyaan',
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
                controller: judulController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Judul'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: descController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Isi Pertanyaan'),
                maxLines: 5,
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
                  if (judulController.text.isNotEmpty &&
                      descController.text.isNotEmpty) {
                    await ServiceForumTanya.addThread(
                        judulController.text.trim(),
                        descController.text.trim());
                    Toast.show("Thread telah di buat", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    FocusScope.of(context).unfocus();
                    judulController.text = "";
                    descController.text = "";
                  } else {
                    Toast.show(
                        "judul dan deskripsi tidak boleh kosong", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
