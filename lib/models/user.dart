import 'emergency_contact.dart';

class User {
  final String name;
  final String email;
  final String phone;
  final String emergencyContact; // Keep for backward compatibility
  final List<EmergencyContact> emergencyContacts;

  const User({
    required this.name,
    required this.email,
    required this.phone,
    required this.emergencyContact,
    this.emergencyContacts = const [],
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'emergencyContact': emergencyContact,
      'emergencyContacts': emergencyContacts
          .map((contact) => contact.toJson())
          .toList(),
    };
  }

  // Create from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    List<EmergencyContact> contacts = [];
    if (json['emergencyContacts'] != null) {
      contacts = (json['emergencyContacts'] as List)
          .map((contactJson) => EmergencyContact.fromJson(contactJson))
          .toList();
    }

    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      emergencyContact: json['emergencyContact'] as String,
      emergencyContacts: contacts,
    );
  }

  // Create a copy with updated fields
  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? emergencyContact,
    List<EmergencyContact>? emergencyContacts,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email, phone: $phone, emergencyContact: $emergencyContact, emergencyContacts: $emergencyContacts)';
  }
}
