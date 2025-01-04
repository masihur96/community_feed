class APIs {
  // Base URL
  static const String baseUrl = "https://iap.ezycourse.com";

  //To Login
  static const String feedLogin = baseUrl + "/api/app/student/auth/login";

  //To Community Feed
  static const String getCommunityFeed =
      baseUrl + "/api/app/teacher/community/getFeed?status=feed&";
  //To Create Feed
  static const String createFeed =
      baseUrl + "/api/app/teacher/community/createFeedWithUpload?";

  //To Create Reaction
  static const String createReaction =
      baseUrl + "/api/app/teacher/community/createLike?=&=&=&=";

  //To get Reaction
  static const String reactionList =
      baseUrl + "api/app/teacher/community/getAllReactionType?feed_id=180370";

  //To Get Comment
  static const String getComment =
      baseUrl + "api/app/student/comment/getComment/:feedI_id?more=null";

  //To Create Comment
  static const String createComment =
      baseUrl + "api/app/student/comment/createComment";

//To Add Reply
  static const String addReply =
      baseUrl + "api/app/student/comment/createComment";

//To Get Reply
  static const String getReply =
      baseUrl + "/api/app/student/comment/getReply/61231?more=null";

//To LogOut
  static const String logout = baseUrl + "/api/app/student/auth/logout";
}
