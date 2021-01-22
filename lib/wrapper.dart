import 'package:chc_design/login_screen.dart';
import 'package:chc_design/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var user;
  @override
  Widget build(BuildContext context) {
     user = Provider.of<User>(context);

    if(user !=null){
      return NavScreen();
    }else{
      return LoginScreen();
    }
  }
}