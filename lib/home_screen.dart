import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String flavor;

  // Declare the constructor as const
  const HomeScreen({Key? key, required this.flavor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home1 - $flavor'),
      ),
      body: Center(
        child: const Text(
          'Welcome to the  version of YourAppName!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}