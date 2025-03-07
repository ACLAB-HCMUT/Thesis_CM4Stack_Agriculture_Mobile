import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_screen.dart';

// Rename the variable to follow lowerCamelCase convention
Future<void> mainCommon({
  required String flavor,
  required FirebaseOptions firebaseOptions,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the provided configuration
  await Firebase.initializeApp(
    options: firebaseOptions,
  );

  runApp(MaterialApp(
    home: HomeScreen(flavor: flavor),
  ));
}