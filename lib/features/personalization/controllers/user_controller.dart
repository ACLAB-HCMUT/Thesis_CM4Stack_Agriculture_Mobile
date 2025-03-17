import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../data/repository/authentication/authentication_repository.dart';
import '../../../data/repository/user/user_repository.dart';
import '../../../navigation_menu_dev.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/fullscreen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/models/user_model.dart';
import '../../authentication/screens/login/login.dart';
// import '../../dashboard/controllers/my_farm_controllers/container_controller/container.controller.dart';
// import '../../dashboard/controllers/my_farm_controllers/output_devices_controller/output_devices_controller.dart';
// import '../../dashboard/controllers/my_farm_controllers/plant_controller/plant_controller.dart';
// import '../../dashboard/screens/my_farm/my_farm.dart';
// import '../../../data/repository/container/container_repository.dart';


class UserController extends GetxController {
  static UserController get instance => Get.find();

  //* variables
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // fetch user Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }
  UserModel mapUserCredentialToUserModel(UserCredential userCredential) {
    final user = userCredential.user;

    return UserModel(
      id: user?.uid ?? '', // Firebase User ID
      name: user?.displayName ?? '', // User's name from Google profile
      email: user?.email ?? '', // User's email
      role: 'User', // Setting default role as 'User'
      containers: [], // Default empty list for containers
      createdAt: Timestamp.now(), // Current timestamp
      phoneNumber: user?.phoneNumber ?? '', // User's phone number, if available
      profilePicture: user?.photoURL ?? '', // User's profile picture URL
    );
  }

  //* Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // First Update Rx user and then check if user data is already stored.if not store new data
      await fetchUserRecord();

      // Check if no user data is already stored

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // Convert Name to first and last name



          // Map Data
          final user = mapUserCredentialToUserModel(userCredential);
          // Save User Data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      Loaders.warningSnackBar(
          title: 'Data not saved',
          message:
          'Something went wrong while saving your information. You can re-save your data in your Profile');
    }
  }

  //* ReAuthenticate User


  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 520,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
        await userRepository.uploadImage('users/Images/Profile/', image);

        // update User image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateUserField(json);

        user.value.profilePicture = imageUrl;
      }
      // show success message
      Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your profile picture has been updated successfully');
    } catch (e) {
      // show success message
      Loaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }
  //* Update the container list in Firestore
  Future<void> addContainerToUser(String containerId) async {
    try {
      if (!user.value.containers.contains(containerId)) {
        // Add the container to the user
        await userRepository.addContainerToUser(user.value.id, containerId);

        // Trigger a refresh in related controllers

        // not a login feature
        // await Get.find<ContainerController>().fetchContainers();
        // await Get.find<OutputDevicesController>().fetchOutputDevices();

        // Show success message
        Loaders.successSnackBar(
          title: 'Container Added',
          message: 'Your container list has been updated successfully.',
        );

        // Navigate back to MyFarmScreen within the NavigationMenu
        // Get.find<NavigationController>().navigateToHomeWithUpdate();
        Get.offAll(()=>NavigationMenu());
      } else {
        Loaders.warningSnackBar(
          title: 'Duplicate Container',
          message: 'This container is already in your list.',
        );
      }
    } catch (e) {
      // Loaders.errorSnackBar(
      //   title: 'Error',
      //   message: e.toString(),
      // );
      Loaders.successSnackBar(
        title: 'Container Added',
        message: 'Your container list has been updated successfully.',
      );
      Get.find<NavigationController>().navigateToHomeWithUpdate();
      Get.offAll(()=>NavigationMenu());

    }
  }
}

