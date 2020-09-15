import "package:flutter/material.dart";

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}