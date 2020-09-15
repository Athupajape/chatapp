import 'dart:io';

import 'package:chatapp/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitfn,this.isLoading);
  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext ctx
  ) submitfn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey=GlobalKey<FormState>();
  var _isLogin=true;
  String _userEmail=' ';
  String _userName=' ';
  String _userPassword=' ';
  File _userImageFile;

  void _pickImage(File image){
    _userImageFile=image;
  }

  void _trySubmit(){
    final isvalid=_formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(_userImageFile==null && !_isLogin){
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Please upload an Image"),backgroundColor: Theme.of(context).errorColor,),
      );
      return;
    }

    if(isvalid){
      _formkey.currentState.save();
      widget.submitfn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userImageFile,
        _isLogin,
        context
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          margin: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formkey,
                child: Column(
                children: <Widget>[
                  if(!_isLogin) UserImagePicker(_pickImage),
                  TextFormField(
                    key: ValueKey("email"),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    validator: (value){
                      if(value.isEmpty || !value.contains('@')){
                        return "Please enter valid email address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email Address"),
                    onSaved: (value){
                      _userEmail=value;
                    },
                  ),
                  if(!_isLogin)
                  TextFormField(
                    key: ValueKey("username"),
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    validator: (value){
                      if(value.isEmpty || value.length<4){
                        return "Please enter a valid username.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    onSaved: (value){
                      _userName=value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey("password"),
                    validator: (value){
                      if(value.isEmpty || value.length<7){
                        return 'Password should be atleast of 8 characters.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    obscureText: true,
                    onSaved: (value){
                      _userPassword=value;
                    },
                  ),
                  SizedBox(height:12),
                  if(widget.isLoading)
                    CircularProgressIndicator(),
                  if(!widget.isLoading)
                    RaisedButton(child: Text(_isLogin ? "Login" : "SignUp"),onPressed:_trySubmit),
                  if(!widget.isLoading)
                  FlatButton(onPressed: (){
                    setState(() {
                    _isLogin=!_isLogin;  
                    });
                    
                  }, child:Text(_isLogin ? "Create New Account" : "I already have an account"),textColor: Theme.of(context).primaryColor,)
                ],
              ),
            ),
            ),
        ),
      ));
  }
}