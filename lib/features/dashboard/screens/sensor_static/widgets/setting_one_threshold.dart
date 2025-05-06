import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:triple_h/utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/my_farm_controllers/sensor_controller/sensor_realtime_controller.dart';
import '../../../controllers/my_farm_controllers/plant_controller/plant_controller.dart';

class SettingThreshold extends StatefulWidget {
  final String name;  // Sensor name/id (e.g., 'tempSensor1')
  final double minThreshold;
  final double maxThreshold;
  final String plantId;  // Added to identify which plant to update
  final String sensorType;  // Added to store sensor type (e.g., 'temperature')

  const SettingThreshold({
    Key? key,
    required this.name,
    required this.minThreshold,
    required this.maxThreshold,
    required this.plantId,
    required this.sensorType,
  }) : super(key: key);

  @override
  State<SettingThreshold> createState() => _SettingThresholdState();
}

class _SettingThresholdState extends State<SettingThreshold> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers
  late TextEditingController _minController;
  late TextEditingController _maxController;

  // Create controller for this view
  late final PlantController plantController;

  // Focus nodes for better control
  final FocusNode _minFocusNode = FocusNode();
  final FocusNode _maxFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _minController = TextEditingController(text: widget.minThreshold.toString());
    _maxController = TextEditingController(text: widget.maxThreshold.toString());
    plantController = Get.find<PlantController>();
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    _minFocusNode.dispose();
    _maxFocusNode.dispose();
    super.dispose();
  }

  // Validator for numeric input
  String? _validateNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Add this to unfocus when tapping outside
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: TColors.lightContainer,
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: TColors.light,
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Min value text field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Min value: '),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _minController,
                            focusNode: _minFocusNode,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              hintText: 'Enter minimum value',
                              isDense: true,
                            ),
                            validator: _validateNumeric,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_maxFocusNode);
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Max value text field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Max value: '),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _maxController,
                            focusNode: _maxFocusNode,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              hintText: 'Enter maximum value',
                              isDense: true,
                            ),
                            validator: _validateNumeric,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 100,
                height: 50,
                child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.accent,
                  ),
                  onPressed: plantController.isLoading.value
                      ? null
                      : () {
                    // Unfocus before validation to ensure keyboard dismissal doesn't interfere
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      // Parse the text field values
                      final minValue = double.parse(_minController.text);
                      final maxValue = double.parse(_maxController.text);

                      // Perform additional validation if needed
                      if (minValue >= maxValue) {
                        Get.snackbar(
                            'Validation Error',
                            'Min value must be less than max value',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withOpacity(0.7),
                            colorText: Colors.white
                        );
                        return;
                      }

                      // Call the method to update the thresholds in Firebase
                      plantController.updateSensorThreshold(
                          widget.plantId,    // Plant ID
                          widget.name,       // Sensor name/ID
                          minValue,          // Min value from text field
                          maxValue,          // Max value from text field
                          widget.sensorType  // Sensor type (temperature, humidity, etc.)
                      );
                    }
                  },
                  child: plantController.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TSizes.fontSizeSm,
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}