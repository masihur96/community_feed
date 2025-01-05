import 'package:community_feed_app/models/community_model.dart';
import 'package:community_feed_app/utils/app_color.dart';
import 'package:community_feed_app/utils/screen_size.dart';
import 'package:community_feed_app/viewmodels/auth_viewmodel.dart';
import 'package:community_feed_app/viewmodels/post_viewmodel.dart';
import 'package:community_feed_app/views/components/post_card.dart';
import 'package:community_feed_app/views/screens/create_post_screen.dart';
import 'package:community_feed_app/views/screens/login_screen.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PostViewModel _postViewModel = PostViewModel();
  List<CommunityModel> feedList = [];

  bool _isFetchLoading = false;

  @override
  void initState() {
    getCommunityFeed(); //Set User Object from Preference
    super.initState();
  }

  getCommunityFeed() async {
    _isFetchLoading = true;
    feedList = [];
    feedList = await _postViewModel.getCommunity();
    _isFetchLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                  "Appifylab Assesment 2025",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: FeedColors.feedWhite),
                ),
                Text(
                  "Welcome to the Appifylab Community",
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
              child: _isFetchLoading
                  ? Center(child: const CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: feedList.length,
                      itemBuilder: (context, index) {
                        final post = feedList[index];
                        return PostCard(
                          userName: post.name,
                          feedId: post.id.toString(),
                          profilePic:
                              post.user == null ? "" : post.user!.profilePic,
                          postTime: post.createdAt.toString(),
                          postText: post.feedTxt,
                          imageUrl: post.files.isEmpty
                              ? ""
                              : post.files.first.fileLoc,
                          likes: post.likeCount,
                          comments: post.commentCount,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: FeedColors.feedGreyLight,
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
                      onPressed: () async {
                        AuthViewModel _authViewModel = AuthViewModel();
                        bool? isSuccess = await _authViewModel.logOut();

                        if (isSuccess != null && isSuccess) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Somthing went wrong"),
                            ),
                          );

                          Navigator.of(context).pop();
                        }
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
