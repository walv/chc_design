import 'package:flutter/material.dart';

class DetailTanyaJawab extends StatefulWidget {
  @override
  _DetailTanyaJawabState createState() => _DetailTanyaJawabState();
}

class _DetailTanyaJawabState extends State<DetailTanyaJawab> {
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
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
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Description",
                    maxLines: 5,
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
                ),
                Divider(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10 + 3,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    if (index > 10) {
                      return SizedBox(height: 40);
                    }
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Commentar",
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
        ],
      ),
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
              child: TextField(),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}
