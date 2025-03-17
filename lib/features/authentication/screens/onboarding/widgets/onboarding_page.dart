import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,

  });

  final String image, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          // GREENFARM Logo Image
          Image(image: AssetImage(TImages.applicationLogo)),

          // Space between logo and title
           // Adjust as needed

          // Title Text GREEN FARM
          Text(
            'GREEN FARM',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: TColors.titleColor, // Set the desired color
            ),
            textAlign: TextAlign.center,
          ),


          // Main Image for Onboarding
          Image(
            height: THelperFunctions.screenHeight() * 0.6, // Pass context to get screen height
            width: THelperFunctions.screenWidth() * 0.8,
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),

          // Reduce space between the image and the title
         // This makes the title closer to the image

          // The title "Grow Your Own Green Paradise"
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: TColors.success, // Set the desired color
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
