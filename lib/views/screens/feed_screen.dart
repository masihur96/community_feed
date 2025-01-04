import 'package:community_feed_app/models/post_model.dart';
import 'package:community_feed_app/utils/app_color.dart';
import 'package:community_feed_app/utils/screen_size.dart';
import 'package:community_feed_app/views/components/comment_bottomsheet.dart';
import 'package:community_feed_app/views/screens/create_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/post_viewmodel.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PostViewModel _postViewModel = PostViewModel();
  List<CommunityModel> feedList = [];

  @override
  void initState() {
    getCommunityFeed(); //Set User Object from Preference
    super.initState();
  }

  getCommunityFeed() async {
    //Get Server Community Data
    List<CommunityModel> communityModel = await _postViewModel.getCommunity();

    print(communityModel.length);

    // if (communityModel != null) {}
  }

  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context);
    final List<Map<String, dynamic>> posts = [
      {
        "userName": "Alexander John",
        "postTime": "2 days ago",
        "postText":
            "Hello everyone, this is a post from app to see if attached link is working or not. Here is a link https://www.merriam-webster.com/dictionary/link but I think this is not working. This should work but not working!!!!",
        "imageUrl": "https://via.placeholder.com/400",
        "likes": 2,
        "comments": 12,
      },
      {
        "userName": "Emily Watson",
        "postTime": "1 hour ago",
        "postText": "This is another post to check functionality. Welcome!",
        "imageUrl": "https://via.placeholder.com/400",
        "likes": 5,
        "comments": 20,
      },
      {
        "userName": "John Doe",
        "postTime": "5 minutes ago",
        "postText": "Flutter development is awesome! #Flutter",
        "imageUrl": "https://via.placeholder.com/400",
        "likes": 10,
        "comments": 50,
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Set custom height
        child: AppBar(
          backgroundColor: FeedColors.tealDeep, // Background color

          title: GestureDetector(
            onTap: () {
              getCommunityFeed();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize(context, .02),
                ),
                Text(
                  "Python Developer Community",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: FeedColors.feedWhite),
                ),
                Text(
                  "#General",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: FeedColors.feedWhite),
                ),
              ],
            ),
          ),

          centerTitle: true,

          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IconButton(
              icon: const Icon(Icons.notes_outlined,
                  size: 40, color: FeedColors.feedWhite),
              onPressed: () {
                // Add menu action here
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Input Section
            Container(
              decoration: BoxDecoration(
                color: FeedColors.feedWhite,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/person.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CreatePostScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Write Something here...",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.teal), // Background color
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Border radius
                          ),
                        ),
                        padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12), // Padding
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreatePostScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Post",
                        style: TextStyle(color: Colors.white), // Text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Post Cards
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return _buildPostCard(
                    userName: post['userName'],
                    postTime: post['postTime'],
                    postText: post['postText'],
                    imageUrl: post['imageUrl'],
                    likes: post['likes'],
                    comments: post['comments'],
                    context: context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Logout",
          ),
        ],
        onTap: (index) {
          showBouncingAlertDialog(context);

          // Handle navigation
        },
      ),
    );
  }

  void showBouncingAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Center(child: Text("Logout")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Are you sure, you want to logout?"),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Yes"),
                    ),
                    const VerticalDivider(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("No"),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget _buildPostCard({
  required String userName,
  required String postTime,
  required String postText,
  required BuildContext context,
  String? imageUrl,
  required int likes,
  required int comments,
}) {
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
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.white),
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
                      postTime,
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

        // Post Image (if available)
        if (imageUrl != null) ...[
          SizedBox(height: 10),
          Image.network(
            imageUrl,
            fit: BoxFit.fitWidth,
            height: screenSize(context, .4),
            width: screenSize(context, 1),
          ),
        ],

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
                      color: FeedColors.feedBlack, fontWeight: FontWeight.w800),
                )),
          ],
        ),
      ],
    ),
  );
}
