import 'package:chatapp/screens/auth_screen.dart';
import 'package:chatapp/screens/chatscreen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      primarySwatch: Colors.pink,
      backgroundColor: Colors.pink,
      accentColor: Colors.deepPurple,
      accentColorBrightness: Brightness.dark,
      buttonTheme: ButtonTheme.of(context).copyWith(
        buttonColor: Colors.pink,
        textTheme: ButtonTextTheme.primary,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder:(ctx,usersnapshot){
        if(usersnapshot.connectionState==ConnectionState.waiting){
          return Splashscreen();
        }
        if(usersnapshot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      }),
    );
  }
}

