import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/network/network_manager.dart';
import '../../../../utils/popups/fullscreen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/user_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //* variables
  final localStorage = GetStorage();

  final email = TextEditingController(); //Controller for email input
  final password = TextEditingController(); //Controller for password input
  GlobalKey<FormState> loginFormKey =
  GlobalKey<FormState>(); //Form key for Form validation

  final hidePassword = true.obs; //observable for hiding / showing password
  final rememberMe = false.obs;

  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  //* Email and password Sign In


  //* Google Sign In
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      FullscreenLoader.openLoadingDialog(
          'Logging you in', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullscreenLoader.stopLoadingDialog();
        return;
      }

      // Login user using Google Authentication
      final userCredential = await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredential);

      // Stop Loading
      FullscreenLoader.stopLoadingDialog();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e,stackTrace) {
      // Stop Loading
      // FullscreenLoader.stopLoadingDialog();
      //
      // // Show Error
      // Loaders.errorSnackBar(
      //   title: 'Oh Snap!',
      //   message: e.toString(),
      // );
      // Stop Loading
      FullscreenLoader.stopLoadingDialog();

      // Print the full error and stack trace for debugging purposes
      print("Error during Google Sign-In: $e");
      print("Stack trace: $stackTrace");

      // Optionally, you can also check if the error is an instance of FirebaseAuthException
      if (e is FirebaseAuthException) {
        print("FirebaseAuthException code: ${e.code}");
        print("FirebaseAuthException message: ${e.message}");
      }

      // Show Error SnackBar to the user with relevant information
      Loaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(), // Display the error as a message to the user
      );
      print("What is the error ? -> ${e.toString()}");

    }
  }
}
