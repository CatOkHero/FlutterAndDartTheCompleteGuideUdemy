import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebaseapp/widgets/chat/messages.dart';
import 'package:flutter_firebaseapp/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(height: 10),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'Logout',
              ),
            ],
            onChanged: (item) {
              if (item == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection('chats/ZtiuW9DsfHB6Y4uXfpvB/messages')
      //         .add({'text': 'This was added by a button'});
      //   },
      // ),
    );
  }
}
