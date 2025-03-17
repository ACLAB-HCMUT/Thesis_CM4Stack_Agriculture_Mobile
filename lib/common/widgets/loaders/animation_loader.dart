import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';



//! A widget for displaying an animating loading indicator with optional text and action button.
class AnimationLoaderWidget extends StatelessWidget {
  //* Default constructor for the AnimationLoaderWidget
  //*
  //* Parameters:
  //*   - text: The text to be displayed below the animation
  //*   - animation: The path to the  lottie animation file
  //*   - showAction: Whether to show an action button below the text
  //*   - onActionPressed: Callback function to be executed when the action button is pressed
  //*   - actionText: The text to be displayed on the action button

  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.onActionPressed,
    this.actionText,
  });

  final String text;
  final String animation;
  final bool showAction;
  final VoidCallback? onActionPressed;
  final String? actionText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Animation
            Lottie.asset(animation,
                width: MediaQuery.of(context).size.width *
                    0.8), // Display the lottie animation
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            //* Text
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            //* Action Button
            showAction
                ? SizedBox(
                    width: 250,
                    child: OutlinedButton(
                        onPressed: onActionPressed,
                        style: OutlinedButton.styleFrom(
                            backgroundColor: TColors.dark),
                        child: Text(
                          actionText!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: TColors.light),
                        )),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
