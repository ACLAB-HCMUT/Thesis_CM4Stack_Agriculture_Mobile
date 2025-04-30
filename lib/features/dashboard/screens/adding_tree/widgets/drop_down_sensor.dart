import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:triple_h/features/dashboard/controllers/my_farm_controllers/adding_new_tre_controller/adding.new.tree.controller.dart';

class dropDownListForSensor extends StatelessWidget {
  const dropDownListForSensor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddingTreeController controller = Get.put(AddingTreeController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double padding = screenWidth * 0.05;


    return Container(
      width: double.infinity, // Set desired width
      padding: EdgeInsets.symmetric(horizontal: padding / 2, vertical: padding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green, width: 1),
      ),
      child: Column(
        children: [
          MultiSelectBottomSheetField<String?>(
            items: controller.items.map((item) => MultiSelectItem<String?>(item, item)).toList(),
            initialValue: controller.selectedItems, // Bind initial values
            title: Text("Select Sensors"),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Colors.green,
                width: 1,
              ),
            ),
            buttonIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.green,
            ),
            buttonText: Text(
              "Select Sensors",
              style: TextStyle(
                color: Colors.green[800],
                fontSize: 16,
              ),
            ),
            onConfirm: (List<String?> values) {
              // Update selected items in the controller
              controller.updateSelectedItems(values.whereType<String>().toList());
            },
            maxChildSize: 0.5, // Controls the height of the bottom sheet (50% of screen height)
            chipDisplay: MultiSelectChipDisplay<String>(
              items: controller.selectedItems
                  .map((item) => MultiSelectItem<String>(item, item))
                  .toList(),
              chipColor: Colors.green.withOpacity(0.1),
              textStyle: TextStyle(color: Colors.green[800]),
              onTap: (value) {
                controller.removeItem(value); // Remove item using the controller
              },
            ),
          ),
        ],
      ),
    );
  }
}
