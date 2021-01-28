import 'package:chc_design/service/service_firestoreage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListquestScreen extends StatefulWidget {
  @override
  _ListquestScreenState createState() => _ListquestScreenState();
}

class _ListquestScreenState extends State<ListquestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forum Tanya Jawab",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Description",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      DateTime.now().toIso8601String(),
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text("Like"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.message_outlined,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text("Comment"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.share,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text("Share"),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
    // return StreamBuilder<QuerySnapshot>(
    //   stream: Servicefstore.getThread(),
    //   builder: (context, snapshot) {
    //   if (snapshot.hasData) {
    //     var list = snapshot.data.docs;
    //     return ListView.builder(
    //       itemCount: list.length,
    //       itemBuilder: (context, index) {
    //         return Text(list[index].data()['thread'],);
    //       },
    //     );
    //   }
    //   return Container(
    //     alignment: Alignment.center,
    //     child: CircularProgressIndicator(),
    //   );
    // });
  }
}
