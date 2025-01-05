class CommunityModel {
  CommunityModel({
    required this.id,
    required this.schoolId,
    required this.userId,
    required this.courseId,
    required this.communityId,
    required this.groupId,
    required this.feedTxt,
    required this.status,
    required this.slug,
    required this.title,
    required this.activityType,
    required this.isPinned,
    required this.fileType,
    required this.files,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.shareId,
    required this.metaData,
    required this.createdAt,
    required this.updatedAt,
    required this.feedPrivacy,
    required this.isBackground,
    required this.bgColor,
    required this.pollId,
    required this.lessonId,
    required this.spaceId,
    required this.videoId,
    required this.streamId,
    required this.blogId,
    required this.scheduleDate,
    required this.timezone,
    required this.isAnonymous,
    required this.meetingId,
    required this.sellerId,
    required this.publishDate,
    required this.isFeedEdit,
    required this.name,
    required this.pic,
    required this.uid,
    required this.isPrivateChat,
    required this.group,
    required this.user,
    required this.poll,
    required this.follow,
    required this.like,
    required this.likeType,
    required this.savedPosts,
    required this.comments,
    required this.meta,
  });

  final int id;
  final int schoolId;
  final int userId;
  final dynamic courseId;
  final int communityId;
  final dynamic groupId;
  final String feedTxt;
  final String status;
  final String slug;
  final String title;
  final String activityType;
  final int isPinned;
  final String fileType;
  final List<FileElement> files;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int shareId;
  final MetaDataClass? metaData;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String feedPrivacy;
  final int isBackground;
  final String bgColor;
  final dynamic pollId;
  final dynamic lessonId;
  final int spaceId;
  final dynamic videoId;
  final dynamic streamId;
  final dynamic blogId;
  final dynamic scheduleDate;
  final String timezone;
  final int isAnonymous;
  final dynamic meetingId;
  final dynamic sellerId;
  final DateTime? publishDate;
  final bool isFeedEdit;
  final String name;
  final String pic;
  final int uid;
  final int isPrivateChat;
  final dynamic group;
  final User? user;
  final dynamic poll;
  final dynamic follow;
  final Like? like;
  final List<LikeType> likeType;
  final dynamic savedPosts;
  final List<dynamic> comments;
  final PurpleMeta? meta;

  @override
  String toString() {
    return "$id, $schoolId, $userId, $courseId, $communityId, $groupId, $feedTxt, $status, $slug, $title, $activityType, $isPinned, $fileType, $files, $likeCount, $commentCount, $shareCount, $shareId, $metaData, $createdAt, $updatedAt, $feedPrivacy, $isBackground, $bgColor, $pollId, $lessonId, $spaceId, $videoId, $streamId, $blogId, $scheduleDate, $timezone, $isAnonymous, $meetingId, $sellerId, $publishDate, $isFeedEdit, $name, $pic, $uid, $isPrivateChat, $group, $user, $poll, $follow, $like, $likeType, $savedPosts, $meta, ";
  }
}

class FileElement {
  FileElement({
    required this.fileLoc,
    required this.originalName,
    required this.extname,
    required this.type,
    required this.size,
  });

  final String fileLoc;
  final String originalName;
  final String extname;
  final String type;
  final int size;

  FileElement copyWith({
    String? fileLoc,
    String? originalName,
    String? extname,
    String? type,
    int? size,
  }) {
    return FileElement(
      fileLoc: fileLoc ?? this.fileLoc,
      originalName: originalName ?? this.originalName,
      extname: extname ?? this.extname,
      type: type ?? this.type,
      size: size ?? this.size,
    );
  }

  factory FileElement.fromJson(Map<String, dynamic> json) {
    return FileElement(
      fileLoc: json["fileLoc"] ?? "",
      originalName: json["originalName"] ?? "",
      extname: json["extname"] ?? "",
      type: json["type"] ?? "",
      size: json["size"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "fileLoc": fileLoc,
        "originalName": originalName,
        "extname": extname,
        "type": type,
        "size": size,
      };

  @override
  String toString() {
    return "$fileLoc, $originalName, $extname, $type, $size, ";
  }
}

class Like {
  Like({
    required this.id,
    required this.feedId,
    required this.userId,
    required this.reactionType,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnonymous,
    required this.meta,
  });

  final int id;
  final int feedId;
  final int userId;
  final String reactionType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int isAnonymous;
  final MetaDataClass? meta;

  Like copyWith({
    int? id,
    int? feedId,
    int? userId,
    String? reactionType,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? isAnonymous,
    MetaDataClass? meta,
  }) {
    return Like(
      id: id ?? this.id,
      feedId: feedId ?? this.feedId,
      userId: userId ?? this.userId,
      reactionType: reactionType ?? this.reactionType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      meta: meta ?? this.meta,
    );
  }

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json["id"] ?? 0,
      feedId: json["feed_id"] ?? 0,
      userId: json["user_id"] ?? 0,
      reactionType: json["reaction_type"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      isAnonymous: json["is_anonymous"] ?? 0,
      meta: json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "feed_id": feedId,
        "user_id": userId,
        "reaction_type": reactionType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_anonymous": isAnonymous,
        "meta": meta?.toJson(),
      };

  @override
  String toString() {
    return "$id, $feedId, $userId, $reactionType, $createdAt, $updatedAt, $isAnonymous, $meta, ";
  }
}

class MetaDataClass {
  MetaDataClass({required this.json});
  final Map<String, dynamic> json;

  factory MetaDataClass.fromJson(Map<String, dynamic> json) {
    return MetaDataClass(json: json);
  }

  Map<String, dynamic> toJson() => {};

  @override
  String toString() {
    return "";
  }
}

class LikeType {
  LikeType({
    required this.reactionType,
    required this.feedId,
    required this.meta,
  });

  final String reactionType;
  final int feedId;
  final MetaDataClass? meta;

  LikeType copyWith({
    String? reactionType,
    int? feedId,
    MetaDataClass? meta,
  }) {
    return LikeType(
      reactionType: reactionType ?? this.reactionType,
      feedId: feedId ?? this.feedId,
      meta: meta ?? this.meta,
    );
  }

  factory LikeType.fromJson(Map<String, dynamic> json) {
    return LikeType(
      reactionType: json["reaction_type"] ?? "",
      feedId: json["feed_id"] ?? 0,
      meta: json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "reaction_type": reactionType,
        "feed_id": feedId,
        "meta": meta?.toJson(),
      };

  @override
  String toString() {
    return "$reactionType, $feedId, $meta, ";
  }
}

class PurpleMeta {
  PurpleMeta({
    required this.views,
  });

  final int views;

  PurpleMeta copyWith({
    int? views,
  }) {
    return PurpleMeta(
      views: views ?? this.views,
    );
  }

  factory PurpleMeta.fromJson(Map<String, dynamic> json) {
    return PurpleMeta(
      views: json["views"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "views": views,
      };

  @override
  String toString() {
    return "$views, ";
  }
}

class User {
  User({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.isPrivateChat,
    required this.expireDate,
    required this.status,
    required this.pauseDate,
    required this.userType,
    required this.meta,
  });

  final int id;
  final String fullName;
  final String profilePic;
  final int isPrivateChat;
  final dynamic expireDate;
  final dynamic status;
  final dynamic pauseDate;
  final String userType;
  final MetaDataClass? meta;

  User copyWith({
    int? id,
    String? fullName,
    String? profilePic,
    int? isPrivateChat,
    dynamic? expireDate,
    dynamic? status,
    dynamic? pauseDate,
    String? userType,
    MetaDataClass? meta,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      profilePic: profilePic ?? this.profilePic,
      isPrivateChat: isPrivateChat ?? this.isPrivateChat,
      expireDate: expireDate ?? this.expireDate,
      status: status ?? this.status,
      pauseDate: pauseDate ?? this.pauseDate,
      userType: userType ?? this.userType,
      meta: meta ?? this.meta,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      fullName: json["full_name"] ?? "",
      profilePic: json["profile_pic"] ?? "",
      isPrivateChat: json["is_private_chat"] ?? 0,
      expireDate: json["expire_date"],
      status: json["status"],
      pauseDate: json["pause_date"],
      userType: json["user_type"] ?? "",
      meta: json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_pic": profilePic,
        "is_private_chat": isPrivateChat,
        "expire_date": expireDate,
        "status": status,
        "pause_date": pauseDate,
        "user_type": userType,
        "meta": meta?.toJson(),
      };

  @override
  String toString() {
    return "$id, $fullName, $profilePic, $isPrivateChat, $expireDate, $status, $pauseDate, $userType, $meta, ";
  }
}
