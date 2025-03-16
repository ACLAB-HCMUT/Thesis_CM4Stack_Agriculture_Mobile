
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class Loaders {
  static void hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: THelperFunctions.isDarkMode(Get.context!)
                  ? TColors.darkerGrey.withOpacity(0.9)
                  : TColors.grey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }

  static void successSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      duration: Duration(seconds: duration),
      backgroundColor: TColors.primary,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color: TColors.white),
    );
  }

  static void warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: TColors.warning,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }

  static void errorSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }
}
