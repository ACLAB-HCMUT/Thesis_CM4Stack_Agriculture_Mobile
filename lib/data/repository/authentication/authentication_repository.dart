
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'package:google_sign_in/google_sign_in.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';
// import '../../../features/dashboard/controllers/my_farm_controllers/container_controller/container.controller.dart';
import '../../../navigation_menu_dev.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //* Variables
  final deviceStorage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get Authenticated User Data
  User? get authUser => _auth.currentUser;




  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }


  screenRedirect() {
    final user = _auth.currentUser;
    if (user != null) {
        Get.offAll(() => const NavigationMenu());

    } else {
      //* Local Storage

      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authenticatio flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await userAccount?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      print(e);
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print('something went wrong: $e');
      }
      // throw 'something went wrong. Please try again';
      return null;
    }
  }

  /* ------------- ./end Federated identity & social sign-in ------------- */

  // * [LogoutUser] - valid for any authentication

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  // * Delete User - Remove user Auth and Firestore Account
  /// This will delete the current logged in account from both firebase auth and firestore database.


}
