import 'package:chc_design/service/service_fireauth.dart';
import 'package:chc_design/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: Servicefauth.currentUser()),
      ],
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(
            seconds: 5,
            navigateAfterSeconds: Wrapper(),
            image: new Image.asset('assets/catsplashhome.jpg'),
            backgroundColor: Colors.white,
            photoSize: 100.0,
            loaderColor: Colors.blue,
            loadingText: Text(
              '©Copyright M.Programming\n2020',
              textAlign: TextAlign.center,
            )),
      ),
    );
  }}
