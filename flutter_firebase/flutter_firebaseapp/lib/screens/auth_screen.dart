import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebaseapp/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _sumbitAuthForm(
    String email,
    String username,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }

      if (authResult.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (err) {
      var message = 'An error occured';
      // if (err.message != null) {
      //   message = err.message;
      // }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
    } catch (err) {} finally {
      setState(() {
        _isLoading = false;
      });
    }

    // if (authResult.)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : AuthForm(_sumbitAuthForm),
    );
  }
}
