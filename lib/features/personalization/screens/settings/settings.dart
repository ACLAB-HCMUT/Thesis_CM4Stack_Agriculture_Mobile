
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/containers/header_component.dart';
import '../../../../common/widgets/list_tile/settings_menu_tile.dart';
import '../../../../common/widgets/list_tile/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repository/authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../profile/profile.dart';
// import 'qr_code_scanner_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //? Header
            PrimaryHeaderComponent(
              child: Column(
                children: [
                  //? AppBar
                  TAppBar(
                    title: Text(
                      'Accounts',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),

                  ),

                  //? UserProfile Card
                  UserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),

            //?  Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //? Account Settings
                  const SectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  SettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notification message',
                    onTap: () {},

                  ),
                  SettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected account',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.convert,
                    title: 'Switch Container',
                    subTitle: 'Switch between different containers',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.scan,
                    title: 'Adding Container',
                    subTitle: 'Adding new container',
                    onTap: () {
                      // Get.to(() => QRCodeScannerScreen());
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        child: const Text('Logout')),
                  ),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
