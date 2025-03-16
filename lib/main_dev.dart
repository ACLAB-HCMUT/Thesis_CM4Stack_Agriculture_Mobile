import 'main_common.dart';
import 'firebase_options_dev.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:triple_h/utils/constants/api_constants.dart';
import 'app_dev.dart';
import 'data/repository/authentication/authentication_repository.dart';
Future<void> main() async {
  await mainCommon(
    flavor: 'dev',
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  // TODO : init local storage
  await GetStorage.init();
  // TODO : init payment methods
  // TODO : await native splash
  // TODO : Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  // TODO : Initialize Authentication
  // Gemini.init(apiKey: geminiAPIKEy);
  runApp(const MyApp());

}