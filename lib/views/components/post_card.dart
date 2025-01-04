import 'package:community_feed_app/utils/app_color.dart';
import 'package:community_feed_app/utils/screen_size.dart';
import 'package:community_feed_app/views/components/comment_bottomsheet.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String userName;
  final String profilePic;
  final String postTime;
  final String postText;
  final String imageUrl;
  final int likes;
  final int comments;

  const PostCard({
    super.key,
    required this.userName,
    required this.profilePic,
    required this.postTime,
    required this.postText,
    required this.imageUrl,
    required this.likes,
    required this.comments,
  });

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
                  profilePic.isEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.white),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                            profilePic,
                          ),
                        ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                      Text(
                        getTimeAgo(postTime),
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
            postText,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),

          SizedBox(height: 5),
          // Post Image (if available)
          if (imageUrl.isNotEmpty)
            Image.network(
              imageUrl,
              fit: BoxFit.fitWidth,
              height: screenSize(context, .4),
              width: screenSize(context, 1),
            ),

          SizedBox(height: 10),

          // Reactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                  radius: 8,
                  backgroundColor: FeedColors.likeColor,
                  child: Icon(Icons.thumb_up_alt_outlined,
                      size: 10, color: FeedColors.feedWhite)),
              const CircleAvatar(
                  radius: 8,
                  backgroundColor: FeedColors.heartColor,
                  child: Icon(Icons.favorite,
                      size: 10, color: FeedColors.feedWhite)),
              const SizedBox(width: 5),
              Text(
                "You and $likes other",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: FeedColors.feedBlack),
              ),
              const Spacer(),
              const Icon(Icons.comment_bank_outlined,
                  size: 15, color: FeedColors.feedBlack),
              const SizedBox(width: 5),
              GestureDetector(
                  onTap: () {
                    showBottomSheetDialog(context);
                  },
                  child: Text(
                    "$comments Comments",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: FeedColors.feedBlack),
                  )),
            ],
          ),

          SizedBox(height: 20),

          // Reactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.thumb_up_alt, color: FeedColors.likeColor),
              const SizedBox(width: 5),
              Text(
                "Like",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: FeedColors.likeColor, fontWeight: FontWeight.w800),
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
