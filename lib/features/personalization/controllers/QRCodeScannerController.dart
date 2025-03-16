import 'package:get/get.dart';

class QRCodeScannerController extends GetxController {
  var scannedData = ''.obs;

  void updateScannedData(String data) {
    scannedData.value = data;
  }
}
