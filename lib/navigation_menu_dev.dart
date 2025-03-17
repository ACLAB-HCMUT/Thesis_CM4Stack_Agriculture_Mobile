import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_h/features/dashboard/screens/my_farm/my_farm.dart';
import 'package:triple_h/utils/constants/colors.dart';
import 'package:triple_h/utils/constants/image_strings.dart';
import 'package:triple_h/utils/helpers/helper_functions.dart';
// import 'features/dashboard/screens/chart/chart_screen.dart';
// import 'features/dashboard/screens/irrigation/irrigationScreen.dart';
// import 'features/personalization/screens/settings/settings.dart';
// import 'features/dashboard/screens/testHistoricalDataFetching/fetchData.dart';
// import 'features/personalization/screens/settings/settings.dart';
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(

      bottomNavigationBar: Obx(
            () => Container(
          decoration: BoxDecoration(



            color: dark ? TColors.black : TColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // Adjust shadow color
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          margin: const EdgeInsets.all(12), // Add some margin around the bar
          child: NavigationBar(
            backgroundColor: Colors.transparent, // Make background transparent for the container color
            indicatorColor: dark
                ? TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
            controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                icon: Image(
                  image: !dark
                      ? AssetImage(TImages.myFarmIcon)
                      : AssetImage(TImages.myFarmIcon_dark),
                ),
                label: 'My Farm',
              ),
              NavigationDestination(
                icon: Image(
                  image: !dark
                      ? AssetImage(TImages.analyticIcon)
                      : AssetImage(TImages.analyticIcon_dark),
                ),
                label: 'Analytics',
              ),
              NavigationDestination(
                icon: Image(
                  image: !dark
                      ? AssetImage(TImages.irrigationIcons)
                      : AssetImage(TImages.irrigationIcons_dark),
                ),
                label: 'Irrigation',
              ),
              NavigationDestination(
                icon: Image(
                  image: !dark
                      ? AssetImage(TImages.profileIcon)
                      : AssetImage(TImages.profileIcon_dark),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final ValueNotifier<int> selectedTabIndex = ValueNotifier<int>(0);
  final screens = [
    MyFarmScreen(),
    // SettingsScreen(),
    // // SchedulerPage(),
    // IrrigationScreen(),
    // SettingsScreen(),

    // const ProfileScreen(),
  ];
  void navigateToHomeWithUpdate() {
    selectedIndex.value = 0; // Navigate to the first tab (homepage)
  }
}
