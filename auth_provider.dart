import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  
  User? get user => _user;
  bool get isLoggedIn => _user != null;

  AuthProvider() {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    _user = _authService.currentUser;
    notifyListeners();
  }

  Future<bool> signUp(String email, String password) async {
    try {
      final user = await _authService.signUp(email, password);
      if (user != null) {
        _user = user;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        _user = user;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

 
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      print('Sign out error: $e');
      rethrow;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      print('Reset password error: $e');
      return false;
    }
  }
}