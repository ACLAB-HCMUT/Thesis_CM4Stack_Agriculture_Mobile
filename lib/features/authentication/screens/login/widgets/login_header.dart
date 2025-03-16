import 'package:flutter/material.dart';


import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      margin: EdgeInsets.only(top: TSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            TTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Colors.green,
            ),
          ),
          const SizedBox(
            height: TSizes.sm,
          ),
          Container(
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center, // Ensures overall centering
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Cultivating Green Space Growing\n',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text: 'Happiness',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}