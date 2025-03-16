import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/image_strings.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    //* Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static String getCategoryImageURL(String category){
    switch (category) {
      case 'Fruit':
        return TImages.fruitCategory;
      case 'Vegetable':
        return TImages.vetatableCategory;
      case 'Herb':
        return TImages.herbCategory;
      case 'Food Crop':
        return TImages.foodCropCategory;
      case 'Industrial Crop':
        return TImages.industryCategory;
      default:
        return TImages.tomato_plants;
    }

  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static String getLottieAnimationPath(String mainCondition) {
    final now = DateTime.now();
    final isDayTime = now.hour >= 6 && now.hour < 18; // Daytime: 6 AM to 6 PM

    switch (mainCondition) {
      case "Clouds":
        return isDayTime ? TImages.cloudsWeatherDay : TImages.cloudsWeatherNight;
      case "Clear":
        return isDayTime ? TImages.sunWeatherDay : TImages.moonWeatherNight;
      case "Rain":
        return isDayTime ? TImages.rainWeatherDay : TImages.rainWeatherNight;
      case "Thunderstorm":
        return isDayTime ? TImages.thunderDay : TImages.thunderNight;
      default:
        return isDayTime ? TImages.sunWeatherDay : TImages.moonWeatherNight; // Default animation
    }
  }


}
