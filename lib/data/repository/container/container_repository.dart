import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triple_h/data/repository/authentication/authentication_repository.dart';
import 'package:triple_h/features/dashboard/models/container_model.dart';

class ContainerRepository extends GetxController{
  FirebaseFirestore _db= FirebaseFirestore.instance;
  static ContainerRepository get instance => Get.find();
  final authRepository= Get.put(AuthenticationRepository());


  @override
  void onInit() {
    super.onInit();

  }

  Future<List<ContainerModel>> fetchContainers(List<String> containerIds) async {
    try {
      // Ensure `containerIds` has at most 10 IDs due to Firestore's limitation on `whereIn`
      if (containerIds.isEmpty) return [];

      final containersQuery = await _db.collection('containers')
          .where(FieldPath.documentId, whereIn: containerIds)
          .get();

      return containersQuery.docs.map((e) => ContainerModel.fromQuerySnapshot(e)).toList();
    } catch (e) {
      throw 'Error fetching containers: $e';
    }
  }

  Future<void> updateRemainingArea(String containerId, double newRemainingArea) async {
    try {
      await _db.collection('containers').doc(containerId).update({
        'remainingArea': newRemainingArea,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('Remaining area updated successfully');
    } catch (e) {
      throw 'Error updating remaining area: $e';
    }
  }
}