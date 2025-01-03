import 'package:community_feed_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      // API call for login
      final response = await AuthService().login(email, password);
      // if (response) {
      //   // Store session data
      //   return true;
      // }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return false;
  }

  void logout() {
    // Clear session and navigate to login screen
  }
}
