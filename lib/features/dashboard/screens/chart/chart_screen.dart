import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_h/features/dashboard/screens/chart/widgets/select_period.dart';
import 'package:triple_h/utils/constants/text_strings.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/shimmers/shimmer_effect.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/handleDataForChart/handleData.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/my_farm_controllers/sensor_controller/sensor_historical_data_controller.dart';

class RoundedContainerChart extends StatelessWidget {
  RoundedContainerChart({
    super.key,
    required this.sensorType,
    required this.sensorId,
  });

  final String sensorId;
  final String sensorType;

  final ValueNotifier<int> selectedTabIndex = ValueNotifier<int>(0);
  final DataHistoricalChartController controller = Get.put(DataHistoricalChartController());

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> lineBarsData = [];
    String nameOfChart = sensorType[0].toUpperCase() + sensorType.substring(1);
    print(nameOfChart);
    print(controller.dataToday.value); // data is not empty
    // initial data fetch
    if (controller.dataToday.value.isEmpty) {
      controller.updateFilter(selectedTabIndex.value, sensorId, sensorType);
    }
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          '$nameOfChart Chart',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColors.companyColor),
        ),
        leadingOnPressed: () {},
        showBackArrow: true,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        print('Loading value: ${controller.isLoading.value}');
        if (controller.isLoading.value) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: Text(
                    sensorType == TTexts.sensorTypeHumid
                        ? TTexts.textChartForHumid
                        : sensorType == TTexts.sensorTypeTemperature
                        ? TTexts.textChartForTemp
                        : TTexts.textForSoil,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: ShimmerEffect(
                    width: THelperFunctions.screenWidth() * 0.9,
                    height: THelperFunctions.screenHeight() * 0.5,
                    radius: 16,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.dataToday.value.isEmpty) {
          return const Center(child: Text("No data available"));
        }
        print('Loading value: ${controller.isLoading.value}');
        print('Data to day value of sensor ${sensorType} is: ${controller.dataToday.value}');
        print('The current filter is: ${controller.currentFilter.value}');
        // Chart data processing based on selected time period
        Map<int, List<FlSpot>> chartDataMap = ProcessDataForChartUtils.processData(
          controller.dataToday.value,
          sensorType,
          controller.currentFilter.value,
        );
        print('CAN REACH HERE ?');
        // Debugging chartDataMap
        print('chartDataMap: $chartDataMap');
        if (chartDataMap.isEmpty || chartDataMap[0] == null || chartDataMap[0]!.isEmpty) {
          print('Error: chartDataMap[0] is empty or null');
          return const Center(child: Text('Error: No data available for this sensor.'));
        }

        // Adding line data to the chart
        if (sensorType == TTexts.sensorTypeHumid) {
          lineBarsData.add(
            LineChartBarData(
              dotData: FlDotData(show: false),
              isCurved: true,
              color: Colors.lightBlueAccent,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              spots: chartDataMap[0]!,
            ),
          );
        } else if (sensorType == TTexts.sensorTypeTemperature) {
          lineBarsData.add(
            LineChartBarData(
              dotData: FlDotData(show: false),
              isCurved: true,
              color: Colors.orangeAccent,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              spots: chartDataMap[0]!,
            ),
          );
        } else {
          // Process Soil Data
          lineBarsData.addAll([
            LineChartBarData(
              dotData: FlDotData(show: false),
              isCurved: true,
              color: Color(0xFF00D1FC),
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              spots: chartDataMap[0]!,
            ),
            LineChartBarData(
              dotData: FlDotData(show: false),
              isCurved: true,
              color: Color(0xFFFFA500),
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              spots: chartDataMap[1]!,
            ),
            LineChartBarData(
              dotData: FlDotData(show: false),
              isCurved: true,
              color: Color(0xFF309A51),
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              spots: chartDataMap[2]!,
            ),
          ]);
        }

        // Debugging lineBarsData
        print('lineBarsData before rendering: $lineBarsData');
        if (lineBarsData.isEmpty) {
          print('Error: lineBarsData is empty');
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Text(
                  'Real-time monitoring of soil moisture for optimal irrigation management.',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Container(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: RoundedContainer(
                  width: THelperFunctions.screenWidth() * 0.9,
                  height: THelperFunctions.screenHeight() * 0.5,
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  radius: 16,
                  gradient: sensorType == TTexts.sensorTypeHumid
                      ? LinearGradient(
                    colors: [Colors.blue.shade50, Colors.blue.shade100],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                      : sensorType == TTexts.sensorTypeTemperature
                      ? LinearGradient(
                    colors: [Color(0xFFFFF8E1), Color(0xFFFFF3C5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                      : LinearGradient(
                    colors: [Colors.green.shade50, Colors.green.shade200],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  child: Column(
                    children: [
                      ValueListenableBuilder<int>(
                        valueListenable: selectedTabIndex,
                        builder: (context, currentIndex, _) {
                          if (controller.currentFilter.value != currentIndex) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              try {
                                controller.updateFilter(currentIndex, sensorId, sensorType); // Update filter after build
                                lineBarsData.clear();
                              } catch (error) {
                                debugPrint("Error updating filter: $error");
                              }
                            });
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              periodSelect(
                                selectedTabIndex: selectedTabIndex,
                                title: "Today",
                                index: 0,
                                currentIndex: currentIndex,
                              ),
                              periodSelect(
                                selectedTabIndex: selectedTabIndex,
                                title: "Week",
                                index: 1,
                                currentIndex: currentIndex,
                              ),
                              periodSelect(
                                selectedTabIndex: selectedTabIndex,
                                title: "Month",
                                index: 2,
                                currentIndex: currentIndex,
                              ),
                              periodSelect(
                                selectedTabIndex: selectedTabIndex,
                                title: "Year",
                                index: 3,
                                currentIndex: currentIndex,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: sensorType == TTexts.sensorTypeHumid
                                      ? 20
                                      : sensorType == TTexts.sensorTypeTemperature
                                      ? 15
                                      : 50,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) => Text(
                                    "${value.toInt()}${sensorType == TTexts.sensorTypeHumid ? "%" : sensorType == TTexts.sensorTypeTemperature ? "°C" : ""}",
                                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                                  ),
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: controller.currentFilter.value == 0 ? 6 : 1,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) {
                                    // Handle day, week, month, and year labels
                                    if (controller.currentFilter.value == 0) {
                                      return Text(
                                        "${value.toInt().toString().padLeft(2, '0')}:00",
                                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                                      );
                                    }
                                    // Handle week, month, and year labels similarly
                                    // More logic here...
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: const Border(
                                left: BorderSide(color: Colors.black, width: 2),
                                bottom: BorderSide(color: Colors.black, width: 2),
                              ),
                            ),
                            lineBarsData: lineBarsData,
                            minY: 0,
                            maxY: sensorType == 'humid'
                                ? 100
                                : sensorType == 'temperature'
                                ? 60
                                : sensorType == 'soil'
                                ? 250
                                : 250,
                            minX: 0,
                            maxX: selectedTabIndex.value == 3
                                ? 3
                                : selectedTabIndex.value == 2
                                ? 6
                                : selectedTabIndex.value == 1
                                ? 6
                                : 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Container(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: Text(
                    'Key Insights',
                    style: Theme.of(context).textTheme.headlineMedium,
                  )),
              SizedBox(height: TSizes.spaceBtwItems),
              Container(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: Text(
                    'Recommendations',
                    style: Theme.of(context).textTheme.headlineMedium,
                  )),
            ],
          ),
        );
      }),
    );
  }
}
