import 'package:community_feed_app/models/reaction_model.dart';
import 'package:community_feed_app/utils/app_color.dart';
import 'package:community_feed_app/utils/screen_size.dart';
import 'package:community_feed_app/viewmodels/post_viewmodel.dart';
import 'package:community_feed_app/views/components/comment_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:flutter_chat_reactions/utilities/hero_dialog_route.dart';

class PostCard extends StatefulWidget {
  final String userName;
  final String feedId;
  final String profilePic;
  final String postTime;
  final String postText;
  final String imageUrl;
  final int likes;
  final int comments;

  const PostCard({
    super.key,
    required this.userName,
    required this.feedId,
    required this.profilePic,
    required this.postTime,
    required this.postText,
    required this.imageUrl,
    required this.likes,
    required this.comments,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final PostViewModel postViewModel = PostViewModel();
  List<ReactionModel> reactionList = [];

  @override
  void initState() {
    getReactionList();
    // TODO: implement initState
    super.initState();
  }

  getReactionList() async {
    reactionList = await postViewModel.getReactionList(widget.feedId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  widget.profilePic.isEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.white),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.profilePic,
                          ),
                        ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                      Text(
                        getTimeAgo(widget.postTime),
                        style: Theme.of(context).textTheme.bodySmall!,
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.more_vert),
            ],
          ),
          const Divider(
            thickness: .8,
          ),

          // Post Text
          Text(
            widget.postText,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),

          SizedBox(height: 5),
          // Post Image (if available)
          if (widget.imageUrl.isNotEmpty)
            Image.network(
              widget.imageUrl,
              fit: BoxFit.fitWidth,
              height: screenSize(context, .4),
              width: screenSize(context, 1),
            ),

          SizedBox(height: 10),

          // Reactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              reactionList.isEmpty
                  ? SizedBox()
                  : Row(
                      children: [
                        SizedBox(
                          height: 40, // Adjust height to fit the CircleAvatar
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection:
                                Axis.horizontal, // Set horizontal scrolling
                            itemCount: reactionList.length,
                            itemBuilder: (context, index) {
                              final reaction = reactionList[index];
                              return CircleAvatar(
                                radius: 8,
                                backgroundColor: reaction.reactionType == "LIKE"
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
                                          : reaction.reactionType == "WOW"
                                              ? Icons.emoji_emotions_outlined
                                              : Icons.thumb_up_alt_outlined,
                                  size: 10,
                                  color: FeedColors.feedWhite,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          reactionList.length == 1
                              ? "You"
                              : "You and ${reactionList.length} other",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: FeedColors.feedBlack),
                        ),
                      ],
                    ),
              Row(
                children: [
                  const Icon(Icons.comment_bank_outlined,
                      size: 15, color: FeedColors.feedBlack),
                  const SizedBox(width: 5),
                  GestureDetector(
                      onTap: () {
                        showBottomSheetDialog(context);
                      },
                      child: Text(
                        "${widget.comments} Comments",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: FeedColors.feedBlack),
                      )),
                ],
              ),
            ],
          ),

          SizedBox(height: 20),

          // Reactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onLongPress: () {
                  final PostViewModel _postViewModel = PostViewModel();
                  // navigate with a custom [HeroDialogRoute] to [ReactionsDialogWidget]
                  Navigator.of(context).push(
                    HeroDialogRoute(
                      builder: (context) {
                        return ReactionsDialogWidget(
                          id: "1",
                          menuItems: const [],
                          menuItemsWidth: 0, // unique id for message
                          messageWidget: SizedBox(), // message widget
                          onReactionTap: (reaction) async {
                            print('reaction: ${reaction}');
                            String reactionType = "LIKE";
                            if (reaction == "👍") {
                              reactionType = "LIKE";
                            } else if (reaction == "❤️") {
                              reactionType = "LOVE";
                            } else if (reaction == "😂") {
                              reactionType = "HAHA";
                            } else {
                              reactionType = "ANGRY";
                            }

                            bool? isSuccess =
                                await _postViewModel.createReaction(
                                    feedId: widget.feedId,
                                    reactionType: reactionType);

                            print("FFFFFFFF: $isSuccess");
                            if (isSuccess != null && isSuccess) {
                              getReactionList();
                            }
                          },
                          onContextMenuTap: (menuItem) {
                            print('menu item: $menuItem');
                            // handle context menu item
                          },
                        );
                      },
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.thumb_up_alt, color: FeedColors.likeColor),
                    const SizedBox(width: 5),
                    Text(
                      "Like",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: FeedColors.likeColor,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.comment_bank,
                color: FeedColors.feedBlack,
              ),
              const SizedBox(width: 5),
              GestureDetector(
                  onTap: () {
                    showBottomSheetDialog(context);
                  },
                  child: Text(
                    "Comment",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: FeedColors.feedBlack,
                        fontWeight: FontWeight.w800),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  String getTimeAgo(String timestamp) {
    // Parse the timestamp
    DateTime parsedTime = DateTime.parse(timestamp).toUtc();
    DateTime currentTime = DateTime.now().toUtc();

    // Calculate the difference
    Duration difference = currentTime.difference(parsedTime);

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  void main() {
    String timestamp = "2025-01-03T18:51:06.000+00:00";
    print(getTimeAgo(timestamp)); // Example usage
  }
}
