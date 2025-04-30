import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:triple_h/features/dashboard/screens/irrigation/statusOfIrrigation/widget/IrrigationCards.dart';
import 'package:triple_h/features/dashboard/screens/irrigation/statusOfIrrigation/widget/categoryTabHorizontal.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/my_farm_controllers/container_controller/container.controller.dart';
import '../../controllers/my_farm_controllers/plant_controller/plant_controller.dart';
import '../my_farm/widgets/adding_plants.dart';
import '../my_farm/widgets/category_tab.dart';
import '../my_farm/widgets/farming_advisory.dart';
import '../my_farm/widgets/weather_widget.dart';

class IrrigationScreen extends StatelessWidget {
  IrrigationScreen({super.key});
  final containerController = Get.put(ContainerController());
  final plantController = Get.put(PlantController());

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
                expandedHeight: THelperFunctions.screenHeight() * 0.2,
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
                      SearchContainer(text: 'GreenFarm', showBackground: true,padding: EdgeInsets.symmetric(horizontal: THelperFunctions.screenWidth()*0.03),),

                    ],
                  ),
                ),
                bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('Controllers')),
                    Tab(child: Text('Controllers History')),
                    Tab(child: Text('Schedule History')),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
              children: [
                CategoryTabHorizontal(),
                CategoryTabHorizontal(),
                CategoryTabHorizontal(),



              ],
            ),
          ),
        ),
      );


  }
}


