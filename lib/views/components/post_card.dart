import 'package:flutter/material.dart';

import '../../models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.username),
        subtitle: Text(post.content),
      ),
    );
  }
}
