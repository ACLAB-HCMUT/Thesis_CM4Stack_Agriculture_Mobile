import 'package:cloud_firestore/cloud_firestore.dart';

// class SchedulerModel {
//   String scheduleId;
//   DateTime startDate;
//   DateTime endDate;
//   String status; // e.g., "scheduled", "completed", "canceled"
//
//   SchedulerModel({
//     required this.scheduleId,
//     required this.startDate,
//     required this.endDate,
//     required this.status,
//   });
//
//   // Factory method to create a SchedulerModel from Firestore snapshot
//   factory SchedulerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
//     final data = snapshot.data();
//     if (data != null) {
//       return SchedulerModel(
//         scheduleId: snapshot.id,
//         startDate: (data['startDate'] as Timestamp).toDate(),
//         endDate: (data['endDate'] as Timestamp).toDate(),
//         status: data['status'] ?? 'scheduled',
//       );
//     } else {
//       throw Exception("Invalid Firestore data for SchedulerModel");
//     }
//   }
//
//   // Convert a SchedulerModel into a Firestore-compatible map
//   Map<String, dynamic> toJson() {
//     return {
//       'startDate': Timestamp.fromDate(startDate),
//       'endDate': Timestamp.fromDate(endDate),
//       'status': status,
//     };
//   }
// }
class SchedulerModel {
  final String id; // Unique ID for the scheduler
  final String function; // Common field
  final String mode; // Common field
  final String outputDeviceId; // Common field
  final DateTime? startTime; // Optional (specific to mode "scheduler_on_off")
  final DateTime? endTime; // Optional (specific to mode "scheduler_on_off")
  final DateTime? timeTrigger; // Optional (specific to mode "scheduler_on")

  // Constructor with optional fields
  SchedulerModel({
    required this.id,
    required this.function,
    required this.mode,
    required this.outputDeviceId,
    this.startTime,
    this.endTime,
    this.timeTrigger,
  });

  // Factory method to dynamically create a SchedulerModel from Firebase data
  factory SchedulerModel.fromMap(String id, Map<String, dynamic> data) {
    return SchedulerModel(
      id: id,
      function: data['function'] ?? '',
      mode: data['mode'] ?? '',
      outputDeviceId: data['outputDeviceId'] ?? '',
      startTime: data.containsKey('startTime')
          ? DateTime.parse(data['startTime'])
          : null,
      endTime: data.containsKey('endTime') ? DateTime.parse(data['endTime']) : null,
      timeTrigger: data.containsKey('timeTrigger')
          ? DateTime.parse(data['timeTrigger'])
          : null,
    );
  }

  // Convert model to JSON for saving to Firebase
  Map<String, dynamic> toJson() {
    final json = {
      'function': function,
      'mode': mode,
      'outputDeviceId': outputDeviceId,
    };
    if (startTime != null) json['startTime'] = startTime!.toIso8601String();
    if (endTime != null) json['endTime'] = endTime!.toIso8601String();
    if (timeTrigger != null) json['timeTrigger'] = timeTrigger!.toIso8601String();
    return json;
  }
}
