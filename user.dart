import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final DateTime createdAt;
  final List<String> favorites;
  final List<Map<String, dynamic>> cart;

  UserModel({
    required this.uid,
    required this.email,
    required this.createdAt,
    this.favorites = const [],
    this.cart = const [],
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String uid) {
    // تحويل Timestamp إلى DateTime
    DateTime createdAt;
    if (data['createdAt'] is Timestamp) {
      createdAt = (data['createdAt'] as Timestamp).toDate();
    } else if (data['createdAt'] is DateTime) {
      createdAt = data['createdAt'] as DateTime;
    } else {
      createdAt = DateTime.now();
    }

    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      createdAt: createdAt,
      favorites: List<String>.from(data['favorites'] ?? []),
      cart: List<Map<String, dynamic>>.from(data['cart'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'createdAt': createdAt,
      'favorites': favorites,
      'cart': cart,
    };
  }
}