import 'dart:developer';

import 'package:community_feed_app/services/data_provider.dart';
import 'package:community_feed_app/utils/apis.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final DataProvider _dataProvider = DataProvider();

  Future<bool?> logIn({
    required String email,
    required String password,
  }) async {
    bool _isSuccess = false;

    dynamic data = {
      "email": email.toLowerCase(),
      "password": password,
    };
    print("Login Data: $data");

    var response =
        await _dataProvider.fetchData("POST", APIs.feedLogin, data: data);

    if (response != null) {
      try {
        if (response.statusCode == 200) {
          _isSuccess = true;
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

  Future<bool?> logOut({
    required String email,
    required String password,
  }) async {
    bool _isSuccess = false;

    dynamic data = {
      "email": email.toLowerCase(),
      "password": password,
    };
    print("Login Data: $data");

    var response =
        await _dataProvider.fetchData("POST", APIs.logout, data: data);

    if (response != null) {
      try {
        if (response.statusCode == 200) {
          _isSuccess = true;
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
