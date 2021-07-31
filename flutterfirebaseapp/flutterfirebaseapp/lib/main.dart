import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaseapp/screens/auth_screen.dart';
import 'package:flutterfirebaseapp/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }

          return AuthScreen();
        },
        stream: FirebaseAuth.instance.authStateChanges().asBroadcastStream(),
      ),
    );
  }
}
