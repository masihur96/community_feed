import 'dart:developer';

import 'package:community_feed_app/services/data_provider.dart';
import 'package:community_feed_app/utils/apis.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class PostViewModel extends ChangeNotifier {
  final DataProvider _dataProvider = DataProvider();

  // Method to create a new notice
  Future<bool> createFeed({
    required String title,
    required String message,
  }) async {
    bool _isSuccess = false;
    // Prepare data for POST request
    dynamic data;
    data = {
      "title": title,
      "message": message,
    };

    // Perform the POST request
    var response = await _dataProvider.fetchData(
      "POST",
      APIs.createFeed,
      data: data,
    );

    try {
      if (response!.statusCode == 201) {
        _isSuccess = true;
      } else {
        _isSuccess = false;
      }
    } catch (exception, stackTrace) {
      // Log exception and capture it using Sentry for error monitoring
      _isSuccess = false;
      log(exception.toString());
      log(stackTrace.toString());
    }

    return _isSuccess;
  }

  // Method to fetch Feeds
  Future<List<PostModel>> getFeeds({
    required String communityId,
  }) async {
    List<PostModel> feedsData = []; // List to store the fetched notices
    // Request header

    dynamic query = {
      "communityId": communityId, // Uncomment if needed
    };
    // Perform the GET request
    var response = await _dataProvider.fetchData("GET", APIs.getCommunityFeed,
        query: query);

    if (response != null) {
      if (response.statusCode == 200) {
        try {
          var data = response.data["data"];
        } catch (e, stackTrace) {
          // Log the error and stack trace
          print(e);
          print(stackTrace);
          // Optionally, handle the error or rethrow it
          rethrow; // Rethrow exception if necessary
        }
      } else {
        // Handle HTTP error response
        throw Exception('Failed to load notices: ${response.statusMessage}');
      }
    }

    return feedsData; // Return the list of notices
  }
}
