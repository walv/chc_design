import 'package:chc_design/detail_tanya_jawab.dart';
import 'package:chc_design/model/forum_tanya_model.dart';
import 'package:chc_design/service/service_forum_tanya.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body: StreamBuilder<QuerySnapshot>(
          stream: ServiceForumTanya.getThread(),
          builder: (context, value) {
            if (!value.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.data.docs.length == 0) {
              return Center(
                child: Text("Belum ada thread"),
              );
            } else {
              var listPertanyaan = value.data.docs
                  .map(
                      (thread) => ForumTanya.fromJSON(thread.id, thread.data()))
                  .toList();
              return Container(
                child: ListView.builder(
                  itemCount: value.data.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailTanyaJawab(
                                    listPertanyaan[index].id)));
                      },
                      child: Container(
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
                              listPertanyaan[index].judul,
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
                                listPertanyaan[index].desc,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                DateFormat.yMMMMEEEEd()
                                    .format(listPertanyaan[index].date),
                              ),
                            ),
                            Divider(),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
