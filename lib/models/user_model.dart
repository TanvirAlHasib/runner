import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.photoURL,
    required this.createdAt,
  });

  final String uid;
  final String username;
  final String email;
  final String? photoURL;
  final DateTime createdAt;

  // Convert UserModel into a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'photoURL': photoURL,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Convert Firestore Map into UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      photoURL: map['photoURL'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}