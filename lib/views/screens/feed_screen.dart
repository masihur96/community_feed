import 'package:community_feed_app/views/components/comment_bottomsheet.dart';
import 'package:community_feed_app/views/screens/create_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/post_viewmodel.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Python Developer Community"),
        leading: Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Input Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
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
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Write Something here...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Post"),
                  ),
                ],
              ),
            ),

            // Post Card 1
            _buildPostCard(
                userName: "Alexander John",
                postTime: "2 days ago",
                postText:
                    "Hello everyone, this is a post from app to see if attached link is working or not. Here is a link https://www.merriam-webster.com/dictionary/link but I think this is not working. This should work but not working!!!!",
                imageUrl:
                    "https://via.placeholder.com/400", // Placeholder image
                likes: 2,
                comments: 12,
                context: context),

            // Post Card 2
            _buildPostCard(
                userName: "Ruiz Rahim",
                postTime: "2 days ago",
                postText: "This is sample Test for Checking",
                imageUrl: null, // No image
                likes: 0,
                comments: 0,
                context: context),
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
    padding: const EdgeInsets.all(16.0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      postTime,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),

            // Post Text
            Text(postText),

            // Post Image (if available)
            if (imageUrl != null) ...[
              SizedBox(height: 10),
              Image.network(imageUrl, fit: BoxFit.cover),
            ],

            SizedBox(height: 10),

            // Reactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined, color: Colors.blue),
                    SizedBox(width: 5),
                    Text("$likes"),
                    SizedBox(width: 20),
                    Icon(Icons.comment_outlined, color: Colors.grey),
                    SizedBox(width: 5),
                    GestureDetector(
                        onTap: () {
                          showBottomSheetDialog(context);
                        },
                        child: Text("$comments Comments")),
                  ],
                ),
                Icon(Icons.more_vert),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
