import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:triple_h/features/dashboard/models/area_model.dart';


class AreaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch area data and return it as AreaModel
  Future<AreaModel> getAreaData(String areaId) async {
    try {
      // Fetch the area document from Firestore
      DocumentSnapshot areaSnapshot = await _firestore.collection('areas').doc(areaId).get();

      // Check if the document exists
      if (!areaSnapshot.exists) {
        throw Exception('Area not found');
      }

      // Convert Firestore data to AreaModel using the factory constructor
      return AreaModel.fromFirestore(areaSnapshot.id, areaSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error fetching area data: $e');
    }
  }
}