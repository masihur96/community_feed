import 'package:community_feed_app/models/comment_model.dart';
import 'package:community_feed_app/models/reaction_model.dart';
import 'package:community_feed_app/utils/app_color.dart';
import 'package:community_feed_app/utils/screen_size.dart';
import 'package:community_feed_app/utils/time_ago.dart';
import 'package:community_feed_app/viewmodels/post_viewmodel.dart';
import 'package:community_feed_app/widgets/feed_text_form_field.dart';
import 'package:flutter/material.dart';

class CommentBottomSheet extends StatefulWidget {
  final List<ReactionModel> reactionList;
  final String feedId;
  final String feedUseId;
  const CommentBottomSheet({
    super.key,
    required this.reactionList,
    required this.feedId,
    required this.feedUseId,
  });

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final PostViewModel postViewModel = PostViewModel();

  final TextEditingController _messageController = TextEditingController();

  List<CommentModel> commentList = [];
  @override
  void initState() {
    getComment();
    // TODO: implement initState
    super.initState();
  }

  getComment() async {
    commentList = await postViewModel.getComment(widget.feedId);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets, // Adjust for keyboard

            child: SingleChildScrollView(
              child: SizedBox(
                height: screenSize(
                  context,
                  1.5,
                ),
                child: Column(
                  children: [
                    // Main content
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(12.0),
                        children: [
                          // Reactions Section
                          if (widget.reactionList.isNotEmpty)
                            Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.reactionList.length,
                                    itemBuilder: (context, index) {
                                      final reaction =
                                          widget.reactionList[index];
                                      return CircleAvatar(
                                        radius: 8,
                                        backgroundColor: reaction
                                                    .reactionType ==
                                                "LIKE"
                                            ? FeedColors.likeColor
                                            : reaction.reactionType == "LOVE"
                                                ? FeedColors.heartColor
                                                : reaction.reactionType == "WOW"
                                                    ? Colors.yellow.shade700
                                                    : FeedColors.loginButton,
                                        child: Icon(
                                          reaction.reactionType == "LIKE"
                                              ? Icons.thumb_up_alt_outlined
                                              : reaction.reactionType == "LOVE"
                                                  ? Icons.favorite
                                                  : reaction.reactionType ==
                                                          "WOW"
                                                      ? Icons
                                                          .emoji_emotions_outlined
                                                      : Icons
                                                          .thumb_up_alt_outlined,
                                          size: 10,
                                          color: FeedColors.feedWhite,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.reactionList.length == 1
                                      ? "You"
                                      : "You and ${widget.reactionList.length} others",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: FeedColors.feedBlack),
                                ),
                              ],
                            ),
                          const SizedBox(height: 10),

                          // Comments Section
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: commentList.length,
                            itemBuilder: (context, index) {
                              final comment = commentList[index];
                              return CommentWidget(
                                avatar: comment.user?.profilePic ?? "",
                                username: comment.user?.fullName ?? "Unknown",
                                content: comment.commentTxt ?? "",
                                timeAgo:
                                    getTimeAgo(comment.createdAt.toString()),
                                isParent: true,
                                likeCount: comment.likeCount ?? 0,
                                replies: comment.replies.isEmpty
                                    ? []
                                    : comment.replies
                                        .map(
                                          (reply) => CommentWidget(
                                            avatar: reply["profile_pic"] ?? "",
                                            isParent: false,
                                            username: reply["full_name"] ?? "",
                                            content: reply["comment"] ?? "",
                                            timeAgo: "21d",
                                            likeCount: reply["like_count"] ?? 0,
                                          ),
                                        )
                                        .toList(),
                              );
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.15),
                        ],
                      ),
                    ),

                    // Input Field Section
                    Row(
                      children: [
                        Expanded(
                          child: FeedTextFormField(
                            textEditingController: _messageController,
                            prefixIconData: Icons.person,
                            hintText: "Write a Comment",
                            suffixIconData: Icons.send_outlined,
                            suffixOnTap: () {
                              postViewModel
                                  .createComment(
                                      feedId: widget.feedId,
                                      feedUserId: widget.feedUseId,
                                      commentTxt: _messageController.text)
                                  .then(getComment());
                              print("DDDD");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final String avatar;
  final String username;
  final String content;
  final String timeAgo;
  final int likeCount;
  final bool isParent;
  final List<CommentWidget>? replies;

  const CommentWidget({
    Key? key,
    required this.avatar,
    required this.username,
    required this.content,
    required this.timeAgo,
    required this.isParent,
    required this.likeCount,
    this.replies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            avatar.isEmpty
                ? CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, color: Colors.white),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(
                      avatar,
                    ),
                  ),
            const SizedBox(width: 8),
            // Comment Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username and Content
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(username,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text(content,
                                  style:
                                      Theme.of(context).textTheme.bodySmall!),
                            ],
                          ),
                          Icon(Icons.more_horiz_outlined, size: 16),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),
                  // Metadata (Time, Like, Reply)
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Text(timeAgo,
                          style: Theme.of(context).textTheme.bodySmall!),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          // Handle Like Action
                        },
                        child: Text("Like",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: FeedColors.likeColor)),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          // Handle Reply Action
                        },
                        child: Text("Reply",
                            style: Theme.of(context).textTheme.bodySmall!),
                      ),
                      const Spacer(),
                      // Like Count and Icon
                      Row(
                        children: [
                          Text("$likeCount",
                              style: Theme.of(context).textTheme.bodySmall!),
                          const SizedBox(width: 4),
                          const CircleAvatar(
                            backgroundColor: FeedColors.likeColor,
                            radius: 8,
                            child: Icon(
                              Icons.thumb_up_alt_outlined,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Nested Replies
        if (replies != null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0), // Indent replies
            child: Column(
              children: replies!,
            ),
          ),
      ],
    );
  }
}
