// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// import '../../../../../common/widgets/containers/rounded_container.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/helpers/helper_functions.dart';
//
// class FarmingAdvisory extends StatelessWidget {
//   const FarmingAdvisory({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return RoundedContainer(
//       shadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.2),
//           spreadRadius: 1,
//           blurRadius: 5,
//           offset: Offset(0, 2), // Shadow at the bottom
//         ),
//       ],
//       width: THelperFunctions.screenWidth(),
//       height: THelperFunctions.screenHeight() * 0.05, // Adjust the height for a slimmer bar
//       backgroundColor: TColors.advisorBarColor, // Light beige color
//       padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace), // Add horizontal padding only
//       margin: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
//       radius: TSizes.xs, // Small corner radius
//       showBorder: true,
//       borderColor: TColors.companyColor, // Green border color
//       child: GestureDetector(
//         onTap: (){},
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Farming Advisory',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.black,
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               color: Colors.black,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

// /// Responsive Farming Advisory bar
//
// import 'package:flutter/material.dart';
// import '../../../../../common/widgets/containers/rounded_container.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/helpers/helper_functions.dart';
//
// class FarmingAdvisory extends StatelessWidget {
//   const FarmingAdvisory({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions for responsive sizing
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;
//
//     // Adjust the height and font size based on screen width
//     final double containerHeight = screenHeight * 0.05; // Responsive height
//     final double padding = screenWidth * 0.04; // Responsive padding
//     final double fontSize = screenWidth * 0.04; // Responsive font size
//     final double iconSize = screenWidth * 0.05; // Responsive icon size
//
//     return RoundedContainer(
//       shadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.2),
//           spreadRadius: 1,
//           blurRadius: 5,
//           offset: Offset(0, 2), // Shadow at the bottom
//         ),
//       ],
//       width: screenWidth,
//       height: containerHeight, // Adjusted for responsiveness
//       backgroundColor: TColors.advisorBarColor, // Light beige color
//       padding: EdgeInsets.symmetric(horizontal: padding), // Responsive padding
//       margin: EdgeInsets.symmetric(horizontal: padding),
//       radius: TSizes.xs, // Small corner radius
//       showBorder: true,
//       borderColor: TColors.companyColor, // Green border color
//       child: GestureDetector(
//         onTap: () {},
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Farming Advisory',
//               style: TextStyle(
//                 fontSize: fontSize, // Responsive font size
//                 fontWeight: FontWeight.normal,
//                 color: Colors.black,
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               color: Colors.black,
//               size: iconSize, // Responsive icon size
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'chat_screen.dart'; // Import the chat screen

class FarmingAdvisory extends StatelessWidget {
  const FarmingAdvisory({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double containerHeight = screenHeight * 0.05;
    final double padding = screenWidth * 0.04;
    final double fontSize = screenWidth * 0.04;
    final double iconSize = screenWidth * 0.05;

    return RoundedContainer(
      shadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
      width: screenWidth,
      height: containerHeight,
      backgroundColor: TColors.advisorBarColor,
      padding: EdgeInsets.symmetric(horizontal: padding),
      margin: EdgeInsets.symmetric(horizontal: padding),
      radius: TSizes.xs,
      showBorder: true,
      borderColor: TColors.companyColor,
      child: GestureDetector(
        onTap: () {
          // Navigate to the chat screen when tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()), // Use your ChatScreen widget
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Farming Advisory',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}