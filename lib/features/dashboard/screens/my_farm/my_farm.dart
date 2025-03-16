import 'package:flutter/material.dart';
class MyFarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlankScreen(),
    );
  }
}

class BlankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blank Screen'),
      ),
      body: Container(), // Empty body, just a blank screen
    );
  }
}