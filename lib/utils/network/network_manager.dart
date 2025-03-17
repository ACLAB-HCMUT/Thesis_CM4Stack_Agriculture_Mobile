import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../popups/loaders.dart';

//! Manages the network connectivity  status and provides methods to check and handle connectivity changes

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  //* Variables
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    //? Listen to the connectivity changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    //? and update the isConnected variable
  }

//* Update the connection status based on changes in connectivity and show relevent popup for no internet connection
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      //? Show no internet connection popup
      Loaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  //* Check the Internet Connection Status
  //* Returns 'true' if connected ,'false' otherwise
  Future<bool> isConnected() async {
    //? Check if the device is connected to the internet
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  //* Dispose or close the active connectivity stream

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
