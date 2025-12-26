import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';

class FavoritesProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  
  List<Map<String, dynamic>> _favorites = [];
  bool _isLoading = false;
  
  List<Map<String, dynamic>> get favorites => _favorites;
  bool get isLoading => _isLoading;

  Future<void> loadFavorites() async {
    final userId = _authService.getUserId();
    if (userId == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    try {
      _favorites = await _firestoreService.getFavorites(userId);
    } catch (e) {
      print('Error loading favorites: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

 

Future<bool> addToFavorites(Map<String, dynamic> product) async {
  final userId = _authService.getUserId();
  if (userId == null) return false;
  
  try {
    await _firestoreService.addToFavorites(userId, product);
    await loadFavorites(); // Refresh the list
    return true;
  } catch (e) {
    print('Error adding to favorites: $e');
    return false;
  }
}

  Future<void> removeFromFavorites(String productId) async {
    final userId = _authService.getUserId();
    if (userId == null) return;
    
    try {
      await _firestoreService.removeFromFavorites(userId, productId);
      await loadFavorites();
    } catch (e) {
      print('Error removing from favorites: $e');
      rethrow;
    }
  }
}