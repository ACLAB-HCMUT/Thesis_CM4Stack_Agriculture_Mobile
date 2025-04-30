import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import '../../../../navigation_menu_dev.dart';
import '../../controllers/QRCodeScannerController.dart';
import '../../controllers/user_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/colors.dart';
class QRCodeScannerScreen extends StatelessWidget {
  final QRCodeScannerController controller = Get.put(QRCodeScannerController()); // Initialize QR code scanner controller

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Scan QR Code")),
  //     body: Column(
  //       children: [
  //         Expanded(
  //           flex: 4,
  //           child: QRView(
  //             key: GlobalKey(debugLabel: 'QR'),
  //             onQRViewCreated: _onQRViewCreated,
  //             overlay: QrScannerOverlayShape(
  //               borderColor: Colors.green,
  //               borderRadius: 10,
  //               borderLength: 30,
  //               borderWidth: 10,
  //               cutOutSize: 300,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text("QR Code Value:"),
  //                 Obx(() {
  //                   return Text(
  //                     controller.scannedData.value,
  //                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   );
  //                 }),
  //                 SizedBox(height: 12),
  //                 FloatingActionButton(
  //                   onPressed: () {
  //                     if (controller.scannedData.value.isNotEmpty) {
  //                       // Get the container ID and add it to the user’s containers
  //                       String containerId = controller.scannedData.value;
  //                        Get.find<UserController>()
  //                           .addContainerToUser(containerId);
  //                     } else {
  //                       // Handle case when no QR code is scanned
  //                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                         content: Text("No QR code scanned. Please try again."),
  //                       ));
  //                     }
  //                   },
  //                 // FloatingActionButton(
  //                 //   onPressed: () async {
  //                 //     if (controller.scannedData.value.isNotEmpty) {
  //                 //       // Get the container ID and add it to the user’s containers
  //                 //       String containerId = controller.scannedData.value;
  //                 //       await Get.find<UserController>().addContainerToUser(containerId);
  //                 //
  //                 //       // Navigate back to MyFarmScreen within the NavigationMenu
  //                 //       Get.find<NavigationController>().navigateToHomeWithUpdate();
  //                 //     } else {
  //                 //       // Handle case when no QR code is scanned
  //                 //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                 //         content: Text("No QR code scanned. Please try again."),
  //                 //       ));
  //                 //     }
  //                 //   },
  //                   backgroundColor: TColors.accent, // Customize background color
  //                   child: Icon(
  //                       Icons.qr_code_scanner,
  //                       color: TColors.white,
  //                   ), // Icon for QR Code Scanner
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // // This method is called when QR code is detected
  // void _onQRViewCreated(QRViewController qrController) {
  //   qrController.scannedDataStream.listen((scanData) {
  //     controller.updateScannedData(scanData.code ?? "No data");  // Update scanned data
  //   });
  // }
}
