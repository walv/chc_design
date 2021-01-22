import 'package:chc_design/register_screen.dart';
import 'package:chc_design/service/service_fireauth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:chc_design/navigation_screen.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userC = TextEditingController();
  var passwordC = TextEditingController();

  var email;
  var password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Masuk',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Image(image: AssetImage('assets/cat-logo.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextField(
                  controller: userC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Username atau Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextField(
                  controller: passwordC,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 40,
                child: RaisedButton(
                    child: Text('Masuk',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    color: Colors.blue,
                    onPressed: ()async {
                      email = userC.text.trim();
                      password = passwordC.text.trim();
                      if(email.length == 0 || email == null){
                        Toast.show("Email Tidak boleh Kosong" , context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        return;
                      }
                      if(password.length == 0 || password == null){
                        Toast.show("Password Tidak boleh Kosong" , context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        return;
                      }
                     var result= await Servicefauth.login(email, password);

                      if (result=="Login Berhasil") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => NavScreen(),
                                ));
                      } else {
                        Toast.show(result , context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Lupa Kata sandi? Atur Sekarang',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  'Atau masuk dengan',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 40,
                    icon: Icon(MdiIcons.facebook),
                    onPressed: () {},
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(MdiIcons.twitter),
                    onPressed: () {},
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(MdiIcons.google),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Belum ada akun Care and health Cat ?',
                ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 40,
                child: RaisedButton(
                    child: Text('Daftar',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => RegisterScreen(),
                                ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
