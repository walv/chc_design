import 'package:chc_design/service/service_fireauth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        actions: [
        ],
        backgroundColor: Colors.grey[350],

        title: Text(
          'Your Id',
          style: TextStyle(color: Colors.black, ),
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
                'Sayangi Dirimu Seperti Kamu Menyayangi Kucingmu',
                style: TextStyle(color: Colors.orange[700]),
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
                    'Edit profile',
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
              Container(
                width: 110,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Promotions',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                width: 110,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Servicefauth.logout();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );

  }
}