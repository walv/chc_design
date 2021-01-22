import 'package:chc_design/detail_kucing.dart';
import 'package:flutter/material.dart';

class Mycatscreeb extends StatefulWidget {
  @override
  _MycatscreebState createState() => _MycatscreebState();
}

class _MycatscreebState extends State<Mycatscreeb> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        actions: [
          
        ],
        backgroundColor: Colors.grey[350],
        
        title: Text(
          'Your Id',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  // child: photo != null
                  //     ? Container(
                  //         width: 100,
                  //         height: 100,
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           image: DecorationImage(
                  //             fit: BoxFit.fill,
                  //             image: NetworkImage(
                  //               photo,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : 
                  child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                'Your Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Text('Your Description'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 110,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                   
                  },
                ),
              ),
            ],
          ),
          Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10 + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? GestureDetector(
                          onTap: (){
                            print('linked');
                          },
                                              child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                ),
                                child: Icon(Icons.add),
                              ),
                              SizedBox(height: 5),
                              Text('Tambahkan Kucing'),
                            ],
                          ),
                      )
                      : GestureDetector(
                        onTap: (){
                     Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => Detailkucing(),
                                ));   
                        },
                                              child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                ),
                                child: Icon(Icons.person),
                              ),
                              SizedBox(height: 5),
                              Text('Kucing $index'),
                            ],
                          ),
                      );
                },
              ),
            ),
        ],
      ),
    );
  }
}