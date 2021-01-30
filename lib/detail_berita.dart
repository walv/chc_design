
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/berita_model.dart';

class Detailberitascreen extends StatefulWidget {
  final Beritamodel beritamodel;

  const Detailberitascreen({Key key, this.beritamodel}) : super(key: key);

  @override
  _DetailberitascreenState createState() => _DetailberitascreenState();
}

class _DetailberitascreenState extends State<Detailberitascreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Berita Tentang Kucing",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        widget.beritamodel.image,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 10,
                  ),
                  child: Text(
                    widget.beritamodel.judul,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    DateFormat.yMMMMEEEEd()
                                    .format(widget.beritamodel.date),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 10,
                  ),
                  child: Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 10,
                  ),
                  child: Text(
                    "${widget.beritamodel.deskripsi}",
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
Divider(),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.beritamodel.comment.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.beritamodel.comment[index]['username'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      widget.beritamodel.comment[index]['comment'],
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),            
          ],
        ),
      ),
    );
  }
}
