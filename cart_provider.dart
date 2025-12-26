import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';

class CartProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  
  List<Map<String, dynamic>> _cartItems = [];
  bool _isLoading = false;
  
  List<Map<String, dynamic>> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  
  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) {
      return sum + ((item['price'] as double) * ((item['quantity'] as int? ?? 1)));
    });
  }

  Future<void> loadCartItems() async {
    final userId = _authService.getUserId();
    if (userId == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    try {
      _cartItems = await _firestoreService.getCartItems(userId);
    } catch (e) {
      print('Error loading cart: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(Map<String, dynamic> product) async {
    final userId = _authService.getUserId();
    if (userId == null) return;
    
    try {
      await _firestoreService.addToCart(userId, product);
      await loadCartItems();
    } catch (e) {
      print('Error adding to cart: $e');
      rethrow;
    }
  }

  Future<void> removeFromCart(String productId) async {
    final userId = _authService.getUserId();
    if (userId == null) return;
    
    try {
      await _firestoreService.removeFromCart(userId, productId);
      await loadCartItems();
    } catch (e) {
      print('Error removing from cart: $e');
      rethrow;
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final userId = _authService.getUserId();
    if (userId == null) return;
    
    try {
      await _firestoreService.updateCartQuantity(userId, productId, quantity);
      await loadCartItems();
    } catch (e) {
      print('Error updating quantity: $e');
      rethrow;
    }
  }

  Future<void> clearCart() async {
    final userId = _authService.getUserId();
    if (userId == null) return;
    
    try {
      await _firestoreService.clearCart(userId);
      _cartItems.clear();
      notifyListeners();
    } catch (e) {
      print('Error clearing cart: $e');
      rethrow;
    }
  }
}