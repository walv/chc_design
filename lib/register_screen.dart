import 'package:chc_design/login_screen.dart';
import 'package:chc_design/service/service_fireauth.dart';
import 'package:flutter/material.dart';
import 'package:chc_design/navigation_screen.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var userC = TextEditingController();
  var emailC = TextEditingController();
  var passwordC = TextEditingController();

  var username;
  var email;
  var password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Daftar',
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
                  decoration: InputDecoration(hintText: 'Username'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextField(
                  controller: emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email'),
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
                    child: Text('Daftar',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    color: Colors.blue,
                    onPressed: ()async {
                      username = userC.text.trim();
                      email = emailC.text.trim();
                      password = passwordC.text.trim();
                      if(username.length == 0 || username == null){
                        Toast.show("username Tidak boleh Kosong" , context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        return;
                      }
                      if(email.length == 0 || email == null){
                        Toast.show("Email Tidak boleh Kosong" , context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        return;
                      }
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


                     var result= await Servicefauth.daftar(username,email, password);

                      if (result=="Register Berhasil") {
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
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'sudah punya akun Care and health Cat ?',
                ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 40,
                child: RaisedButton(
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    color: Colors.white,
                    onPressed: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => LoginScreen(),
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
