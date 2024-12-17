import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  final Timestamp? createdAt; // Firebase Timestamp
  final String id;            // Primary key
  final String? email;
  final String? name;
  final String? image;
  final String? phone;
  final bool? disabled;
  final List<String>? reviews;

  // Default constructor
  UserDetailsModel({
    this.createdAt,
    required this.id,
    this.email,
    this.name,
    this.image,
    this.phone,
    this.disabled,
    this.reviews,
  });

  // Named constructor for default initialization
  factory UserDetailsModel.initial() {
    return UserDetailsModel(
      createdAt: Timestamp.now(),
      id: "",
      email: null,
      name: null,
      image: null,
      phone: null,
      disabled: null,
      reviews: [],
    );
  }

  // Convert to JSON (Map<String, dynamic>) for Firebase/Serialization
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'id': id,
      'email': email,
      'name': name,
      'image': image,
      'phone': phone,
      'disabled': disabled,
      'reviews': reviews,
    };
  }

  // Factory constructor for creating an instance from JSON
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      createdAt: json['created_at'] as Timestamp?,
      id: json['id'] ?? "",
      email: json['email'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      phone: json['phone'] as String?,
      disabled: json['disabled'] as bool?,
      reviews: (json['reviews'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  @override
  String toString() {
    return 'UserDetailsModel(createdAt: $createdAt, id: $id, email: $email, name: $name, image: $image, phone: $phone, disabled: $disabled, reviews: $reviews)';
  }
}
