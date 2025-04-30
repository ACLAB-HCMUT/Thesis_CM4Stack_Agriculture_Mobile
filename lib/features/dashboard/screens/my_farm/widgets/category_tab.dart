//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:thesis_smart_farm/utils/helpers/helper_functions.dart';
//
// import '../../../../../common/brands/brand_show_case.dart';
// import '../../../../../common/widgets/layouts/grid_layout.dart';
// import '../../../../../common/widgets/products/porduct_card_vertical.dart';
// import '../../../../../common/widgets/texts/section_heading.dart';
// import '../../../../../utils/constants/image_strings.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../controllers/my_farm_controllers/category.controller.dart';
// //
// // class CategoryTab extends StatelessWidget {
// //   const CategoryTab({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView(
// //       shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.all(TSizes.defaultSpace),
// //           child: Column(
// //             children: [
// //               GridLayout(
// //                 mainAxisExtent:THelperFunctions.screenHeight()*0.3,
// //                   itemCount: 6,
// //                   itemBuilder: (_, index) => const ProductCardVertical())
// //               ,SizedBox(
// //                 height: TSizes.spaceBtwItems,
// //               ),
// //             ],
// //
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
//
//
// class CategoryTab extends StatelessWidget {
//   const CategoryTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final CategoryController controller = Get.put(CategoryController());
//
//     return Obx(() {
//       return ListView(
//         controller: controller.scrollController,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisExtent: 220, // Adjust height as needed
//                   ),
//                   itemCount: controller.items.length,
//                   itemBuilder: (_, index) => controller.items[index],
//                 ),
//                 if (controller.isLoading.value)
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: CircularProgressIndicator(),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
//
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_h/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/porduct_card_vertical.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/plant_model.dart';
import '../../../controllers/my_farm_controllers/plant_controller/plant_controller.dart';

class CategoryTab extends StatelessWidget {
   CategoryTab({super.key, required this.plants});
  List<PlantGroupModel> plants;
  @override
  Widget build(BuildContext context) {
    final planController = Get.find<PlantController>();
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //* Brands
                  GridLayout(
                      mainAxisExtent: THelperFunctions.screenHeight() * 0.335,
                      itemCount:plants.length,
                      itemBuilder: (_, index) {
                        bool flag = planController.isConditionWarning(1.0);
                        return ProductCardVertical(
                            plant: plants[index],
                            isConditionWarning: flag,
                        );
                    }
                  )
            ],
          ),
        ),
      ],
    );
  }
}

