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
    return StreamBuilder<QuerySnapshot>(
      stream: Servicefstore.getThread(),
      builder: (context, snapshot) {
      if (snapshot.hasData) {
        var list = snapshot.data.docs;
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Text(list[index].data()['thread'],);
          },
        );
      }
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    });
  }
}