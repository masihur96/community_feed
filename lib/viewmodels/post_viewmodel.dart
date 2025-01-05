import 'dart:developer';

import 'package:community_feed_app/models/reaction_model.dart';
import 'package:community_feed_app/services/data_provider.dart';
import 'package:community_feed_app/services/local_session.dart';
import 'package:community_feed_app/utils/apis.dart';
import 'package:flutter/foundation.dart';

import '../models/community_model.dart';

class PostViewModel extends ChangeNotifier {
  final DataProvider _dataProvider = DataProvider();

  LocalSession localSession = LocalSession();
  // Method to create a new Post
  Future<bool?> createFeed({
    required String post,
    String? bgColor,
  }) async {
    bool _isSuccess = false;
    // Prepare data for POST request

    String? sessionToken = await localSession.getAccessToken();

    const String tokenType = "Bearer";

    // Headers with token
    final headers = {
      "Authorization": "$tokenType $sessionToken", // Include the token
    };
    dynamic data = {
      "feed_txt": post,
      "community_id": "2914",
      "space_id": "5883",
      "uploadType": "text",
      "activity_type": "group",
      if (bgColor != null) "bg_color": bgColor,
      "is_background": bgColor == null ? 0 : 1,
    };

    // Perform the POST request
    var response = await _dataProvider.fetchData(
      "POST",
      APIs.createFeed,
      header: headers,
      data: data,
    );

    print("response::$response");

    try {
      if (response!.statusCode == 200) {
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
  Future<List<CommunityModel>> getCommunity() async {
    List<CommunityModel> feedList = [];

    // Retrieve the session token
    String? sessionToken = await localSession.getAccessToken();

    const String tokenType = "Bearer";

    dynamic data = {
      "community_id": "2914", // Ensure this is valid
      "space_id": "5883", // Replace with actual dynamic value if necessary
    };

    // Headers with token
    final headers = {
      "Authorization": "$tokenType $sessionToken", // Include the token
    };

    // API Call
    var response = await _dataProvider.fetchData(
      "POST",
      APIs.getCommunityFeed,
      data: data,
      header: headers, // Pass the headers
    );

    if (response != null) {
      if (response.statusCode == 200) {
        try {
          dynamic data = response.data;
          for (var json in data) {
            feedList.add(
              CommunityModel(
                id: json["id"] ?? 0,
                schoolId: json["school_id"] ?? 0,
                userId: json["user_id"] ?? 0,
                courseId: json["course_id"],
                communityId: json["community_id"] ?? 0,
                groupId: json["group_id"],
                feedTxt: json["feed_txt"] ?? "",
                status: json["status"] ?? "",
                slug: json["slug"] ?? "",
                title: json["title"] ?? "",
                activityType: json["activity_type"] ?? "",
                isPinned: json["is_pinned"] ?? 0,
                fileType: json["file_type"] ?? "",
                files: json["files"] == null
                    ? []
                    : List<FileElement>.from(
                        json["files"]!.map((x) => FileElement.fromJson(x))),
                likeCount: json["like_count"] ?? 0,
                commentCount: json["comment_count"] ?? 0,
                shareCount: json["share_count"] ?? 0,
                shareId: json["share_id"] ?? 0,
                metaData: json["meta_data"] == null
                    ? null
                    : MetaDataClass.fromJson(json["meta_data"]),
                createdAt: DateTime.tryParse(json["created_at"] ?? ""),
                updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
                feedPrivacy: json["feed_privacy"] ?? "",
                isBackground: json["is_background"] ?? 0,
                bgColor: json["bg_color"] ?? "",
                pollId: json["poll_id"],
                lessonId: json["lesson_id"],
                spaceId: json["space_id"] ?? 0,
                videoId: json["video_id"],
                streamId: json["stream_id"],
                blogId: json["blog_id"],
                scheduleDate: json["schedule_date"],
                timezone: json["timezone"] ?? "",
                isAnonymous: json["is_anonymous"] ?? 0,
                meetingId: json["meeting_id"],
                sellerId: json["seller_id"],
                publishDate: DateTime.tryParse(json["publish_date"] ?? ""),
                isFeedEdit: json["is_feed_edit"] ?? false,
                name: json["name"] ?? "",
                pic: json["pic"] ?? "",
                uid: json["uid"] ?? 0,
                isPrivateChat: json["is_private_chat"] ?? 0,
                group: json["group"],
                user: json["user"] == null ? null : User.fromJson(json["user"]),
                poll: json["poll"],
                follow: json["follow"],
                like: json["like"] == null ? null : Like.fromJson(json["like"]),
                likeType: json["likeType"] == null
                    ? []
                    : List<LikeType>.from(
                        json["likeType"]!.map((x) => LikeType.fromJson(x))),
                savedPosts: json["savedPosts"],
                comments: json["comments"] == null
                    ? []
                    : List<dynamic>.from(json["comments"]!.map((x) => x)),
                meta: json["meta"] == null
                    ? null
                    : PurpleMeta.fromJson(json["meta"]),
              ),
            );
          }

          // CommunityModel.fromJson(response.data);
        } catch (e) {
          if (kDebugMode) {
            print("Error parsing response: $e");
          }
        }
      } else {
        if (kDebugMode) {
          print(
            "Failed with status code: ${response.statusCode} and response: ${response.data}",
          );
        }
      }
    } else {
      if (kDebugMode) {
        print("Response is null. Verify network connectivity and endpoint.");
      }
    }

    return feedList;
  }

  // Method to create a new Post
  Future<bool?> createReaction({
    required String feedId,
    required String reactionType,
  }) async {
    bool _isSuccess = false;
    // Prepare data for POST request
    String? sessionToken = await localSession.getAccessToken();
    const String tokenType = "Bearer";
    // Headers with token
    final headers = {
      "Authorization": "$tokenType $sessionToken", // Include the token
    };
    dynamic data = {
      "feed_id": feedId,
      "reaction_type": reactionType,
    };
    // Perform the POST request
    var response = await _dataProvider.fetchData(
      "POST",
      APIs.createReaction,
      header: headers,
      data: data,
    );
    try {
      if (response!.statusCode == 200) {
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
  Future<List<ReactionModel>> getReactionList(String feedId) async {
    List<ReactionModel> reactionList = [];

    // Retrieve the session token
    String? sessionToken = await localSession.getAccessToken();

    const String tokenType = "Bearer";

    // Headers with token
    final headers = {
      "Authorization": "$tokenType $sessionToken", // Include the token
    };

    // API Call
    var response = await _dataProvider.fetchData(
      "GET",
      "${APIs.reactionList}?feed_id=$feedId",
      header: headers, // Pass the headers
    );

    print("RRRRRRRR;$response");

    if (response != null) {
      if (response.statusCode == 200) {
        try {
          dynamic data = response.data;
          for (var json in data) {
            reactionList.add(
              ReactionModel(
                totalLikes: json["id"] ?? 0,
                reactionType: json["reaction_type"] ?? "Like",
              ),
            );
          }

          // CommunityModel.fromJson(response.data);
        } catch (e) {
          if (kDebugMode) {
            print("Error parsing response: $e");
          }
        }
      } else {
        if (kDebugMode) {
          print(
            "Failed with status code: ${response.statusCode} and response: ${response.data}",
          );
        }
      }
    } else {
      if (kDebugMode) {
        print("Response is null. Verify network connectivity and endpoint.");
      }
    }

    return reactionList;
  }
}
