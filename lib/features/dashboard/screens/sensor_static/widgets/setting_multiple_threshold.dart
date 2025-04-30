import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:triple_h/utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/my_farm_controllers/plant_controller/plant_controller.dart';

class SettingMultipleThreshold extends StatefulWidget {
  final String sensorId; // e.g. 'soilSensor1'
  final String plantId; // ID of the plant to update
  final Map<String, dynamic>? soilValues; // Make nullable to handle the case when it's null

  const SettingMultipleThreshold({
    Key? key,
    required this.sensorId,
    required this.plantId,
    required this.soilValues,
  }) : super(key: key);

  @override
  _SettingMultipleThresholdState createState() => _SettingMultipleThresholdState();
}

class _SettingMultipleThresholdState extends State<SettingMultipleThreshold> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text controllers for all values
  late TextEditingController _kaliMinController;
  late TextEditingController _kaliMaxController;
  late TextEditingController _nitroMinController;
  late TextEditingController _nitroMaxController;
  late TextEditingController _phosMinController;
  late TextEditingController _phosMaxController;

  // Focus nodes for better control
  final FocusNode _kaliMinFocusNode = FocusNode();
  final FocusNode _kaliMaxFocusNode = FocusNode();
  final FocusNode _nitroMinFocusNode = FocusNode();
  final FocusNode _nitroMaxFocusNode = FocusNode();
  final FocusNode _phosMinFocusNode = FocusNode();
  final FocusNode _phosMaxFocusNode = FocusNode();

  // Get the plant controller
  late final PlantController plantController;

  @override
  void initState() {
    super.initState();
    plantController = Get.find<PlantController>();

    // Create a local soilValues map with default values if null
    final Map<String, dynamic> safeValues = widget.soilValues ?? {};

    // Initialize controllers with initial values from the soilValues map
    // Use null-safe access and provide default values
    _kaliMinController = TextEditingController(
        text: safeValues['kali']?['min']?.toString() ?? '5'
    );
    _kaliMaxController = TextEditingController(
        text: safeValues['kali']?['max']?.toString() ?? '15'
    );
    _nitroMinController = TextEditingController(
        text: safeValues['nito']?['min']?.toString() ?? '10'
    );
    _nitroMaxController = TextEditingController(
        text: safeValues['nito']?['max']?.toString() ?? '20'
    );
    _phosMinController = TextEditingController(
        text: safeValues['phospho']?['min']?.toString() ?? '8'
    );
    _phosMaxController = TextEditingController(
        text: safeValues['phospho']?['max']?.toString() ?? '18'
    );
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    _kaliMinController.dispose();
    _kaliMaxController.dispose();
    _nitroMinController.dispose();
    _nitroMaxController.dispose();
    _phosMinController.dispose();
    _phosMaxController.dispose();

    _kaliMinFocusNode.dispose();
    _kaliMaxFocusNode.dispose();
    _nitroMinFocusNode.dispose();
    _nitroMaxFocusNode.dispose();
    _phosMinFocusNode.dispose();
    _phosMaxFocusNode.dispose();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Kali Min & Max Thresholds
              _buildThresholdInputs(
                label: 'Kali',
                minController: _kaliMinController,
                maxController: _kaliMaxController,
                minFocusNode: _kaliMinFocusNode,
                maxFocusNode: _kaliMaxFocusNode,
                nextMinFocusNode: _nitroMinFocusNode,
              ),
              const SizedBox(height: 16),

              // Nitro Min & Max Thresholds
              _buildThresholdInputs(
                label: 'Nitro',
                minController: _nitroMinController,
                maxController: _nitroMaxController,
                minFocusNode: _nitroMinFocusNode,
                maxFocusNode: _nitroMaxFocusNode,
                nextMinFocusNode: _phosMinFocusNode,
              ),
              const SizedBox(height: 16),

              // Phospho Min & Max Thresholds
              _buildThresholdInputs(
                label: 'Phospho',
                minController: _phosMinController,
                maxController: _phosMaxController,
                minFocusNode: _phosMinFocusNode,
                maxFocusNode: _phosMaxFocusNode,
                isLast: true,
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
                        // Parse all values
                        final kaliMin = double.parse(_kaliMinController.text);
                        final kaliMax = double.parse(_kaliMaxController.text);
                        final nitroMin = double.parse(_nitroMinController.text);
                        final nitroMax = double.parse(_nitroMaxController.text);
                        final phosMin = double.parse(_phosMinController.text);
                        final phosMax = double.parse(_phosMaxController.text);

                        // Validate min/max relationships
                        if (kaliMin >= kaliMax || nitroMin >= nitroMax || phosMin >= phosMax) {
                          Get.snackbar(
                              'Validation Error',
                              'Min values must be less than max values',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.withOpacity(0.7),
                              colorText: Colors.white
                          );
                          return;
                        }

                        // Create the updated soil sensor value map
                        final Map<String, dynamic> updatedSoilValues = {
                          'kali': {
                            'min': kaliMin,
                            'max': kaliMax,
                          },
                          'nito': {
                            'min': nitroMin,
                            'max': nitroMax,
                          },
                          'phospho': {
                            'min': phosMin,
                            'max': phosMax,
                          },
                          'type': 'soil',
                        };

                        // Update soil sensor values in Firestore
                        plantController.updateSoilSensorThresholds(
                          widget.plantId,
                          widget.sensorId,
                          updatedSoilValues,
                        );
                      }
                    },
                    child: plantController.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : const Text('Save', style: TextStyle(
                      color: Colors.white,
                      fontSize: TSizes.fontSizeSm,
                    )),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to create a pair of min/max text fields
  Widget _buildThresholdInputs({
    required String label,
    required TextEditingController minController,
    required TextEditingController maxController,
    required FocusNode minFocusNode,
    required FocusNode maxFocusNode,
    FocusNode? nextMinFocusNode,
    bool isLast = false,
  }) {
    return Container(
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$label min value: '),
              SizedBox(
                width: 150,
                child: TextFormField(
                  controller: minController,
                  focusNode: minFocusNode,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    hintText: 'Min value',
                    isDense: true,
                  ),
                  validator: _validateNumeric,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(maxFocusNode);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$label max value: '),
              SizedBox(
                width: 150,
                child: TextFormField(
                  controller: maxController,
                  focusNode: maxFocusNode,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    hintText: 'Max value',
                    isDense: true,
                  ),
                  validator: _validateNumeric,
                  onFieldSubmitted: (_) {
                    if (nextMinFocusNode != null) {
                      FocusScope.of(context).requestFocus(nextMinFocusNode);
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}