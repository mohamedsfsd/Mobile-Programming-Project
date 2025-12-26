import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cart Operations
  Future<void> addToCart(String userId, Map<String, dynamic> product) async {
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(product['id'].toString())
        .set({
          'productId': product['id'],
          'title': product['title'],
          'price': product['price'],
          'image': product['image'],
          'quantity': 1,
          'addedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
  }

  Future<void> removeFromCart(String userId, String productId) async {
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(productId)
        .delete();
  }

  Future<void> updateCartQuantity(String userId, String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(userId, productId);
    } else {
      await _firestore
          .collection('carts')
          .doc(userId)
          .collection('items')
          .doc(productId)
          .update({'quantity': quantity});
    }
  }

  Future<List<Map<String, dynamic>>> getCartItems(String userId) async {
    final snapshot = await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .get();
    
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      data['docId'] = doc.id;
      return data;
    }).toList();
  }

  Future<void> clearCart(String userId) async {
    final snapshot = await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .get();
    
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  // Favorites Operations
  Future<void> addToFavorites(String userId, Map<String, dynamic> product) async {
    await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .doc(product['id'].toString())
        .set({
          'productId': product['id'],
          'title': product['title'],
          'price': product['price'],
          'image': product['image'],
          'addedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
  }

  Future<void> removeFromFavorites(String userId, String productId) async {
    await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .doc(productId)
        .delete();
  }

  Future<List<Map<String, dynamic>>> getFavorites(String userId) async {
    final snapshot = await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .get();
    
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      data['docId'] = doc.id;
      return data;
    }).toList();
  }

  Future<bool> isFavorite(String userId, String productId) async {
    final doc = await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .doc(productId)
        .get();
    
    return doc.exists;
  }

  // User Operations
  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(userId).update(data);
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data();
  }
}