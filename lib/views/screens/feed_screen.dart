import 'package:community_feed_app/views/components/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/post_viewmodel.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Community Feed')),
      body: postViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: postViewModel.posts.length,
              itemBuilder: (_, index) =>
                  PostCard(post: postViewModel.posts[index]),
            ),
    );
  }
}
