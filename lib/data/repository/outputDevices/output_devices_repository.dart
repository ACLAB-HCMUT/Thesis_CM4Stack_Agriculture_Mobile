import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../../features/dashboard/models/output_devices_model.dart';

class OutputDevicesRepository extends GetxController {
  static OutputDevicesRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<List<OutputDeviceModel>> getOutputDevicesByIds(List<String> outputDeviceIds) async {
    try {
      // Batch query Firestore for documents matching the list of IDs
      final List<OutputDeviceModel> outputDevices = [];
      for (String id in outputDeviceIds) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('outputDevices').doc(id).get();

        if (snapshot.exists) {
          outputDevices.add(OutputDeviceModel.fromSnapshot(snapshot));
        }
      }
      return outputDevices;
    } catch (e) {
      print('Error fetching output devices: $e');
      return [];
    }
  }

  Future<void> updateOutputDeviceStatus(String deviceId, String newStatus) async {
    try {
      await _firestore.collection('outputDevices').doc(deviceId).update({
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('Output device status updated successfully');
    } catch (e) {
      throw 'Error updating output device status: $e';
    }
  }
  Future<void> updateOutputDeviceStatusToRealTime(
      String containerId, String deviceId, String name, String newStatus) async {
    try {
      await _database
          .child('containers/$containerId/controllers/$deviceId')
          .set({
        'name': name,
        'status': newStatus,
      });
    } catch (e) {
      throw 'Error updating output device status: $e';
    }
  }
}
