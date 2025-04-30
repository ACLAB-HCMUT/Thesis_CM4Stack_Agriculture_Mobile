import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../features/dashboard/models/scheduler_model.dart';

// class SchedulerRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Fetch a single schedule by its ID
//   Future<SchedulerModel?> getScheduleById(String scheduleId) async {
//     try {
//       final snapshot = await _firestore.collection('schedules').doc(scheduleId).get();
//       if (snapshot.exists) {
//         return SchedulerModel.fromSnapshot(snapshot);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       throw 'Error fetching schedule: $e';
//     }
//   }
//
//   // Fetch all schedules
//   Future<List<SchedulerModel>> getAllSchedules() async {
//     try {
//       final querySnapshot = await _firestore.collection('schedules').get();
//       return querySnapshot.docs.map((doc) => SchedulerModel.fromSnapshot(doc)).toList();
//     } catch (e) {
//       throw 'Error fetching all schedules: $e';
//     }
//   }
//
//   // Create a new schedule
//   Future<void> createSchedule(SchedulerModel schedule) async {
//     try {
//       await _firestore.collection('schedules').add(schedule.toJson());
//     } catch (e) {
//       throw 'Error creating schedule: $e';
//     }
//   }
//
//   // Update a schedule's start and end dates
//   Future<void> updateScheduleDates(String scheduleId, DateTime newStartDate, DateTime newEndDate) async {
//     try {
//       Map<String, dynamic> updatedData = {
//         'endDate': Timestamp.fromDate(newEndDate),
//         'startDate': Timestamp.fromDate(newStartDate),
//       };
//       await _firestore.collection('schedules').doc(scheduleId).update(updatedData);
//     } catch (e) {
//       throw 'Error updating schedule dates: $e';
//     }
//   }
//
//   // Delete a schedule
//   Future<void> deleteSchedule(String scheduleId) async {
//     try {
//       await _firestore.collection('schedules').doc(scheduleId).delete();
//     } catch (e) {
//       throw 'Error deleting schedule: $e';
//     }
//   }
// }
class SchedulerRepository {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Update a scheduler in the database
  Future<void> updateScheduler(
      String containerId,
      String schedulerId,
      Map<String, dynamic> updatedData,
      ) async {
    try {
      // Construct the path to the scheduler in the database
      await _database
          .child('containers/$containerId/$schedulerId')
          .update(updatedData); // Update the scheduler fields
    } catch (e) {
      throw 'Error updating scheduler: $e';
    }
  }

  // Fetch a specific scheduler
  Future<SchedulerModel?> fetchScheduler(
      String containerId,
      String schedulerId,
      ) async {
    try {
      final snapshot = await _database
          .child('containers/$containerId/$schedulerId')
          .get();
      if (snapshot.exists) {
        return SchedulerModel.fromMap(schedulerId, snapshot.value as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw 'Error fetching scheduler: $e';
    }
  }
}
