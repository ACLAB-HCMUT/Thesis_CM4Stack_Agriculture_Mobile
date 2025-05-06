
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_h/features/dashboard/controllers/my_farm_controllers/adding_new_tre_controller/adding.new.tree.controller.dart';
import 'package:triple_h/utils/constants/colors.dart';

class SelectCategory extends StatelessWidget {
  final AddingTreeController controller = Get.find<AddingTreeController>();

  SelectCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth * 0.04;
    final double padding = screenWidth * 0.05;

    return Obx(() => Container(
      width: double.infinity, // Makes the width same as TextFormField
      padding: EdgeInsets.symmetric(horizontal: padding / 4, vertical: padding / 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: DropdownButton<String>(
            value: controller.selectedCategory.value.isEmpty
                ? null
                : controller.selectedCategory.value,
            hint: Row(
                children: [
                  Icon(Icons.category_outlined, color: TColors.dark,),
                  SizedBox(width: 12,),
                  Text(
                    'Select a Category',
                    style: TextStyle(color: Colors.black, fontSize: fontSize),
                  ),
                ],
              ),

            icon: Icon(Icons.arrow_drop_down, color: Colors.grey, size: fontSize * 1.5),
            isExpanded: true, // Expands the dropdown to fill the container
            onChanged: (String? newValue) {
              controller.updateCategory(newValue); // Update selected value using controller
            },
            items: <String>[
              'Vegetable',
              'Fruit',
              'Herb',
              'Food Crop',
              'Industrial Crop',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: TColors.companyColor, fontSize: fontSize)),
              );
            }).toList(),
          ),
        ),
      ),
    ));
  }
}
