import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatter.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;                 // Add role field
  final List<String> containers;      // Add containers field
  final Timestamp createdAt;          // Add createdAt field
  String phoneNumber;
  String profilePicture;

  // Constructor for user model
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.containers,
    required this.createdAt,
    required this.phoneNumber,
    required this.profilePicture,
  });

  // Helper function to format the phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  // Static Function to create an empty user model
  static UserModel empty() => UserModel(
    id: '',
    name: '',
    email: '',
    role: '',
    containers: [],
    createdAt: Timestamp.now(),
    phoneNumber: '',
    profilePicture: '',
  );
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    //? Add more logic to generate username from the full name if needed.
    String camelCaseUserName =
        "$firstName$lastName"; // combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUserName";
    return usernameWithPrefix;
  }


  // Convert model to Json Structure for saving in Firebase Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'containers': containers,
      'createdAt': createdAt,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }

  // Factory method to create a user model from a Firebase DocumentSnapshot
  factory UserModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        role: data['role'] ?? 'user',
        containers: List<String>.from(data['containers'] ?? []),
        createdAt: data['createdAt'] ?? Timestamp.now(),
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    } else {
      return empty();
    }
  }



}
