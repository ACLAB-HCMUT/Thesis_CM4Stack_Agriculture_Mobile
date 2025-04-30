import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:triple_h/features/dashboard/models/area_model.dart';
import 'package:triple_h/features/dashboard/screens/adding_tree/widgets/select_category.dart';
import 'package:triple_h/utils/validators/validation.dart';
import '../../../../../data/repository/areas/area_respository.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/my_farm_controllers/adding_new_tre_controller/adding.new.tree.controller.dart';
import '../../analytics/displayPlant.dart';
import 'drop_down_output_devices.dart';
import 'drop_down_sensor.dart';
// adding_tree_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddingTreeForm extends StatelessWidget {
  const AddingTreeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AddingTreeController addingTreeController = Get.put(AddingTreeController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Adjust sizes based on screen dimensions
    final double fontSize = screenWidth * 0.04;
    final double padding = screenWidth * 0.05;
    final double buttonHeight = screenHeight * 0.07;

    // Fetch data for multiple areas when the view is built
    addingTreeController.fetchAllAreaData();

    return Form(
      key: addingTreeController.addingPlant,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: TSizes.spaceBtwInputFields),
            Text(
              "Choosing area name",
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: TColors.dark,
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ]
              ),
              child: Obx(() {
                // Check if the areasData is loaded
                if (addingTreeController.areasData.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1.1, // Adjusted to reduce bottom space
                  ),
                  itemCount: addingTreeController.areasData.length,
                  itemBuilder: (context, index) {
                    final area = addingTreeController.areasData[index];
                    print(area.id);
                    // Check if this area is selected by comparing its ID with selectedAreaId
                    bool isSelected = addingTreeController.selectedAreaId.value == area.name;
                    print(addingTreeController.selectedAreaId.value);
                    bool isAvailable = area.isAvailable;  // Check if the area is full

                    return GestureDetector(
                      onTap: isAvailable
                          ? () => addingTreeController.selectArea(area.name, area)  // Enable tap if available
                          : null, // Disable tap if the area is full
                      child: Stack(
                        children: [
                          Card(
                            color: TColors.secondary4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: isSelected ? TColors.accent : TColors.dark, // Change border color based on selection
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        area.name,
                                        style: TextStyle(
                                          fontSize: TSizes.fontSizeLg,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(Icons.more_vert),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.sensors, size: TSizes.iconSm),
                                          SizedBox(width: 4),
                                          Text(
                                            "No. sensors",
                                            style: TextStyle(fontSize: TSizes.fontSizeXs),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${area.numSensors}",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.device_hub_sharp, size: TSizes.iconSm),
                                          SizedBox(width: 4),
                                          Text(
                                            "Devices",
                                            style: TextStyle(fontSize: TSizes.fontSizeXs),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${area.numDevices}",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.auto_graph_outlined, size: TSizes.iconSm),
                                          SizedBox(width: 4),
                                          Text(
                                            "Planted",
                                            style: TextStyle(fontSize: TSizes.fontSizeXs),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${area.numPlanted}",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // If the area is full, add an opacity overlay
                          Visibility(
                            visible: !isAvailable, // Only show if the area is not available
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.withOpacity(0.5), // Dim the card
                              ),
                              child: Center(
                                child: Text(
                                  'Not Available',
                                  style: TextStyle(
                                    color: Colors.red[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: TSizes.fontSizeSm,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            Obx (() {
              return Text(
                addingTreeController.selectedAreaId.value != ""
                    ? 'The plant is cultivated at ${addingTreeController.selectedAreaId.value}'
                    : 'No area selected',
                style: TextStyle(fontSize: TSizes.fontSizeSm, fontStyle: FontStyle.italic, color: TColors.accent),
              );
            }),
            SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: addingTreeController.plantVariety,
              validator: (value) => TValidator.validateEmptyText('Plant Variety', value),
              decoration: const InputDecoration(
                labelText: TTexts.addingPlant,
                prefixIcon: Icon(Iconsax.add_circle4),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),

            //* Category Dropdown
            SelectCategory(),
            SizedBox(height: TSizes.spaceBtwInputFields),

            //* Planted Date (Date Picker)
            Obx(() {
              return TextFormField(
                validator: (value) => TValidator.validateDate(value),
                controller: TextEditingController(
                  text: addingTreeController.selectedDate.value,
                ),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Planted Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  hintText: 'Select a date',
                ),
                onTap: () => addingTreeController.selectDate(context),
              );
            }),
            SizedBox(height: TSizes.spaceBtwInputFields),

            //* Submit Button (Green Button)
            SizedBox(
              width: double.infinity,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  // Check validation before calling createNewTree()
                  addingTreeController.createNewTree();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Adding new plant',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

