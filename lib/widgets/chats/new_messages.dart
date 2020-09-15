import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {

  var _enteredMessage='';
  var _controller=new TextEditingController();

  void submitMessage()async{
    FocusScope.of(context).unfocus();
    final user=await FirebaseAuth.instance.currentUser();
    final userData=await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text':_enteredMessage,
      'createdAt':Timestamp.now(),
      'userId':user.uid,
      'username':userData['username'],
      'userImage':userData['image_url']
    });
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(children: [
            Expanded(
                child: TextField(
                decoration: InputDecoration(labelText: "Send a message..."),
                onChanged: (value){
                  setState(() {
                  _enteredMessage=value;  
                  });
                },
                controller: _controller,
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                enableSuggestions: true,
              ),
            ),
            IconButton(color: Theme.of(context).primaryColor,icon: Icon(Icons.send), onPressed:_enteredMessage.trim().isEmpty ? null :submitMessage),
          ],)
        ],
      ),
    );
  }
}