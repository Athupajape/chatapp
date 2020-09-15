import '../widgets/chats/new_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "../widgets/chats/messages.dart";
import "package:firebase_messaging/firebase_messaging.dart";
// import "package:firebase_core/firebase_core.dart";


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm=FirebaseMessaging();
    fbm.configure(onMessage: (msg){
      print(msg);
      return;
    },
    onLaunch: (msg){
      print(msg);
      return;
    },
    onResume: (msg){
      print(msg);
      return;
    },
    );
    fbm.subscribeToTopic('chat');
    // TODO: implement initState
    
  }

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return Scaffold(
    appBar: AppBar(
      title:Text("Flutter Chat"),
      actions:[
        DropdownButton(
          underline: Container(),
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color),
        items:[
          DropdownMenuItem(
            child: Container(
              child: Row(
                children:<Widget> [
                  Icon(Icons.exit_to_app),
                  SizedBox(width:8),
                  Text("Logout"),
                ],
                ),
            ),
            value: 'logout',
            )
        ],
        onChanged: (itemIdentifier){
          if(itemIdentifier=='logout'){
            FirebaseAuth.instance.signOut();
          }
        },
        )
      ]
    ),  
    body:Container(
      child: Column(
        children: [
          Expanded(child: Messages()),
          NewMessages(),
        ],
      ),
    ),
  );
  }
}