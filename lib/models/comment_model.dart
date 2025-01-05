class CommentModel {
  CommentModel({
    required this.id,
    required this.feedId,
    required this.userId,
    required this.replyCount,
    required this.likeCount,
    required this.commentTxt,
    required this.parrentId,
    required this.createdAt,
    required this.privateUserId,
    required this.replies,
    required this.user,
    required this.reactionTypes,
    required this.privateUser,
    required this.totalLikes,
    required this.commentlike,
  });
  final int id;
  final int feedId;
  final int userId;
  final int replyCount;
  final int likeCount;
  final String commentTxt;
  final dynamic parrentId;
  final DateTime? createdAt;
  final dynamic privateUserId;
  final List<dynamic> replies;
  final CommentUser? user;
  final List<dynamic> reactionTypes;
  final dynamic privateUser;
  final List<dynamic> totalLikes;
  final dynamic commentlike;

  @override
  String toString() {
    return "$id, $feedId, $userId, $replyCount, $likeCount, $commentTxt, $parrentId, $createdAt, $privateUserId,  $replies, $user, $reactionTypes, $privateUser, $totalLikes, $commentlike, ";
  }
}

class CommentUser {
  CommentUser({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.userType,
    required this.meta,
  });

  final int id;
  final String fullName;
  final String profilePic;
  final String userType;
  final Meta? meta;

  CommentUser copyWith({
    int? id,
    String? fullName,
    String? profilePic,
    String? userType,
    Meta? meta,
  }) {
    return CommentUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      profilePic: profilePic ?? this.profilePic,
      userType: userType ?? this.userType,
      meta: meta ?? this.meta,
    );
  }

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(
      id: json["id"] ?? 0,
      fullName: json["full_name"] ?? "",
      profilePic: json["profile_pic"] ?? "",
      userType: json["user_type"] ?? "",
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_pic": profilePic,
        "user_type": userType,
        "meta": meta?.toJson(),
      };

  @override
  String toString() {
    return "$id, $fullName, $profilePic, $userType, $meta, ";
  }
}

class Meta {
  Meta({required this.json});
  final Map<String, dynamic> json;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(json: json);
  }

  Map<String, dynamic> toJson() => {};

  @override
  String toString() {
    return "";
  }
}
