import 'package:chc_design/model/forum_tanya_model.dart';
import 'package:chc_design/service/service_firestoreage.dart';
import 'package:chc_design/service/service_forum_tanya.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class DetailTanyaJawab extends StatefulWidget {
  String threadId;

  DetailTanyaJawab(this.threadId);
  @override
  _DetailTanyaJawabState createState() => _DetailTanyaJawabState();
}

class _DetailTanyaJawabState extends State<DetailTanyaJawab> {
  ForumTanya forumTanya;
  var commentController = TextEditingController();
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Tanya jawab",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: ServiceForumTanya.streamForumTanya(widget.threadId),
          builder: (context, value) {
            if (value.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            forumTanya = ForumTanya.fromJSON(value.data.id, value.data.data());
            var liked = forumTanya.like.firstWhere(
                (like) => like["id"] == user.uid,
                orElse: () => null);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          forumTanya.judul,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            forumTanya.desc,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            DateFormat.yMMMMEEEEd().format(forumTanya.date),
                          ),
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ServiceForumTanya.like(widget.threadId,
                                      user.uid, forumTanya.like);
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    liked != null
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.favorite_border,
                                            size: 20,
                                          ),
                                    SizedBox(width: 5),
                                    Text("${forumTanya.like.length}"),
                                    SizedBox(width: 5),
                                    Text("Like"),
                                  ],
                                ),
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
                        ),
                        Divider(),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: forumTanya.comment.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    forumTanya.comment[index]['username'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      forumTanya.comment[index]['comment'],
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                controller: commentController,
              ),
            ),
            FutureBuilder<DocumentSnapshot>(
                future: Servicefstore.getUser(user.uid),
                builder: (context, value) {
                  return IconButton(
                    onPressed: () async {
                      if (commentController.text.isNotEmpty) {
                        ServiceForumTanya.addComment(
                          widget.threadId,
                          user.uid,
                          value.data.data()['username'],
                          commentController.text.trim(),
                          forumTanya.comment,
                        );
                        commentController.text = "";
                        FocusScope.of(context).unfocus();
                      } else {
                        Toast.show("comment tidak boleh kosong", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      }
                    },
                    icon: Icon(Icons.send),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
