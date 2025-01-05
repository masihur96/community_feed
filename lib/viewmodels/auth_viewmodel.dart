import 'dart:developer';

import 'package:community_feed_app/services/data_provider.dart';
import 'package:community_feed_app/services/local_session.dart';
import 'package:community_feed_app/utils/apis.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final DataProvider _dataProvider = DataProvider();
  LocalSession localSession = LocalSession();

  Future<bool?> logIn({
    required String email,
    required String password,
  }) async {
    bool isSuccess = false;

    notifyListeners();
    dynamic data = {
      "email": email.toLowerCase(),
      "password": password,
    };

    var response =
        await _dataProvider.fetchData("POST", APIs.feedLogin, data: data);

    if (response != null) {
      try {
        if (response.statusCode == 200) {
          localSession.setAccessToken(response.data["token"]);

          notifyListeners();
          isSuccess = true;
        } else {
          notifyListeners();
          isSuccess = false;
        }
      } catch (err, stackTrace) {
        isSuccess = false;
        log(err.toString());
        log(stackTrace.toString());
      }

      notifyListeners();
      return isSuccess;
    }
  }

  Future<bool?> logOut() async {
    bool _isSuccess = false;

    String? sessionToken = await localSession.getAccessToken();

    const String tokenType = "Bearer";

    // Headers with token
    final headers = {
      "Authorization": "$tokenType $sessionToken", // Include the token
    };

    var response =
        await _dataProvider.fetchData("POST", APIs.logout, header: headers);

    if (response != null) {
      try {
        if (response.statusCode == 200) {
          _isSuccess = true;
          localSession.clearPrefData();
        } else {
          _isSuccess = false;
        }
      } catch (err, stackTrace) {
        _isSuccess = false;
        log(err.toString());
        log(stackTrace.toString());
      }
      return _isSuccess;
    }
  }
}
