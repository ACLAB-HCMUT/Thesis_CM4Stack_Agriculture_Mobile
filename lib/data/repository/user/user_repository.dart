import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../../features/authentication/models/user_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repository.dart';

//! Repository class for user related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  //* Variables
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //* Function to save user data to firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
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

  //* Function to fetch user details based on User ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapShot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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

  //* Function to update user data in Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection('users')
          .doc(updateUser.id)
          .update(updateUser.toJson());
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

  //* Function to update any field in specific user collection
  Future<void> updateUserField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
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

  //* Function to remove user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
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

  //* upload any image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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
  //* Function to add a container to the user's containers list
  Future<void> addContainerToUser(String userId, String containerId) async {
    try {
      final userDoc = _db.collection('users').doc(userId);
      // Get the current user's containers list
      final userSnapshot = await userDoc.get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data();
        List<String> containers = List<String>.from(data?['containers'] ?? []);

        // Add the new containerId at the beginning of the list if it's not already there
        if (!containers.contains(containerId)) {
          containers.insert(0, containerId); // Add at the beginning of the list
          // Update Firestore with the new containers list
          await userDoc.update({'containers': containers});
        }
      } else {
        throw "User not found.";
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}

