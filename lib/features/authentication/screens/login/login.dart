import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:triple_h/features/authentication/screens/login/widgets/login_header.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../navigation_menu_dev.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/login/login.controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: TSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                children: [
                  // Logo, Title, Subtitle
                  LoginHeader(),

                  SizedBox(height: TSizes.spaceBtwSections * 1),

                  Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: RoundedContainer(
                      margin: EdgeInsets.only(top: TSizes.lg, left: TSizes.sm),
                      height: THelperFunctions.screenHeight() * 0.5,
                      width: THelperFunctions.screenWidth() * 1,
                      showBorder: true,
                      backgroundColor: Colors.white,
                      shadow: [],
                      child: Column(
                        children: [
                          // Logo
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: TSizes.sm),
                            padding: EdgeInsets.all(TSizes.sm),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Image.asset(
                              TImages.applicationLogo,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Text
                          SizedBox(height: TSizes.spaceBtwSections),
                          Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.green),
                          ),
                          SizedBox(height: TSizes.spaceBtwSections),

                          // Login bar
                          Padding(
                            padding: EdgeInsets.only(left: TSizes.sm, right: TSizes.sm, bottom: TSizes.lg),
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () =>controller.googleSignIn(),
                                icon: Image.asset(
                                  TImages.google,
                                  height: TSizes.iconLg,
                                  width: TSizes.iconLg,
                                ),
                                label: Text(TTexts.signIn),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
