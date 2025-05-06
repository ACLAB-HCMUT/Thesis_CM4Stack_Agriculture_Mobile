
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_h/features/dashboard/screens/adding_tree/adding_tree.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class AddingPlants extends StatelessWidget {
  const AddingPlants({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive sizing
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Set sizes based on screen dimensions for responsive UI
    final double containerHeight = screenHeight * 0.1;
    final double padding = screenWidth * 0.04;
    final double fontSize = screenWidth * 0.05;
    final double iconSize = screenWidth * 0.08;

    return RoundedContainer(
      shadow: [],
      padding: EdgeInsets.symmetric(horizontal: padding), // Responsive padding
      margin: EdgeInsets.symmetric(horizontal: padding / 4), // Responsive margin
      backgroundColor: Colors.transparent,
      width: screenWidth, // Full width
      height: containerHeight, // Responsive height
      radius: 0,
      showBorder: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Responsive text
          Text(
            'My Plants',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: TColors.companyColor,
              fontSize: fontSize, // Responsive font size
            ),
          ),



          // Responsive icon button for adding a new plant
          IconButton(
            icon: Image.asset(
              TImages.addingNewPlant,
              width: iconSize, // Responsive icon size
              height: iconSize,
            ),
            color: Colors.black,
            onPressed: () => Get.to(() => AddingTree()),
          ),
        ],
      ),
    );
  }
}
