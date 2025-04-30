import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:triple_h/common/widgets/appbar/appbar.dart';
import 'package:triple_h/features/dashboard/screens/adding_tree/widgets/adding_form.dart';
import 'package:triple_h/features/dashboard/screens/my_farm/my_farm.dart';
import 'package:triple_h/utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/my_farm_controllers/output_devices_controller/output_devices_controller.dart';

class AddingTree extends StatelessWidget {
  const AddingTree({super.key});


  @override
  Widget build(BuildContext context) {
    Get.put(OutputDevicesController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Add Plant Group',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: TColors.companyColor),
        ),
        leadingIcon: Iconsax.arrow_left_2,
        leadingOnPressed:  () => Get.back(result: MyFarmScreen()),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               AddingTreeForm(),
            ],
          ),
        ),
      ),
    );
  }
}
