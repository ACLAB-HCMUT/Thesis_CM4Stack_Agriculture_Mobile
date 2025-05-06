import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triple_h/common/widgets/texts/section_heading.dart';
import 'package:triple_h/data/repository/authentication/authentication_repository.dart';
import 'package:triple_h/features/dashboard/screens/my_farm/widgets/adding_plants.dart';
import 'package:triple_h/features/dashboard/screens/my_farm/widgets/category_tab.dart';
import 'package:triple_h/features/dashboard/screens/my_farm/widgets/farming_advisory.dart';
import 'package:triple_h/features/dashboard/screens/my_farm/widgets/weather_widget.dart';
import 'package:triple_h/features/personalization/controllers/user_controller.dart';
import 'package:triple_h/utils/constants/colors.dart';
import 'package:triple_h/utils/constants/image_strings.dart';
import 'package:triple_h/utils/constants/text_strings.dart';
import 'package:triple_h/utils/helpers/helper_functions.dart';

import '../../../../common/brands/brand_card.dart';
import '../../../../common/brands/brand_show_case.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/porduct_card_vertical.dart';
import '../../../../data/repository/container/container_repository.dart';
import '../../../../data/repository/user/user_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/my_farm_controllers/container_controller/container.controller.dart';
import '../../controllers/my_farm_controllers/plant_controller/plant_controller.dart';


class MyFarmScreen extends StatelessWidget {
  MyFarmScreen({super.key});
  final containerController = Get.put(ContainerController());
  final plantController = Get.put(PlantController());
  final userController = Get.put(UserController());
  // final thresholdController = Get.put(ThresholdController());
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);



    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                expandedHeight: THelperFunctions.screenHeight() * 0.6,
                pinned: true,
                backgroundColor: dark ? Colors.black : Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      SearchContainer(text: 'GreenFarm', showBackground: true,padding: EdgeInsets.symmetric(horizontal:THelperFunctions.screenWidth()*0.03),),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      WeatherWidget(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      FarmingAdvisory(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      AddingPlants(),
                    ],
                  ),
                ),
                bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('All')),
                    Tab(child: Text('Vegetable')),
                    Tab(child: Text('Fruit')),
                    Tab(child: Text('Herb')),
                    Tab(child: Text('Food Crop')),
                    Tab(child: Text('Industrial Crop')),
                  ],
                ),
              )
            ];
          },
          body: Obx(() {
            if (containerController.isLoading.value || plantController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return TabBarView(
              children: [
                CategoryTab(plants: plantController.plantList),
                CategoryTab(
                  plants: plantController.plantList
                      .where((plant) => plant.category.contains('Vegetable'))
                      .toList(),
                ),
                CategoryTab(
                  plants: plantController.plantList
                      .where((plant) => plant.category.contains('Fruit'))
                      .toList(),
                ),
                CategoryTab(
                  plants: plantController.plantList
                      .where((plant) => plant.category.contains('Herb'))
                      .toList(),
                ),
                CategoryTab(
                  plants: plantController.plantList
                      .where((plant) => plant.category.contains('Food Crop'))
                      .toList(),
                ),
                CategoryTab(
                  plants: plantController.plantList
                      .where((plant) => plant.category.contains('Industrial Crop'))
                      .toList(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
