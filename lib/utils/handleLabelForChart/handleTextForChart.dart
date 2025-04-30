import 'package:triple_h/utils/constants/text_strings.dart';

class TextHandlerChart {
  static String handleHeadingForChart(String sensorType) {
    switch (sensorType) {
      case 'humid':
        return TTexts.textChartForHumid;
      case 'temperature':
        return TTexts.textChartForTemp;
      case 'soil':
        return TTexts.textForSoil;
      default:
        return sensorType;
    }
  }
}