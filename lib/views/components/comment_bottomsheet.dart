import 'package:flutter/material.dart';

void showBottomSheetDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Main Comment Bubble with Reply Line
            ChatBubbleWithReplyLine(
              username: "IAP Testing",
              message: "4 cup tcake",
              timeAgo: "22d",
              likes: 1,
              reply: "Hhh",
            ),
            const Spacer(),
            // Comment Input Field
            CommentInputField(),
          ],
        ),
      );
    },
  );
}

class ChatBubbleWithReplyLine extends StatelessWidget {
  final String username;
  final String message;
  final String timeAgo;
  final int likes;
  final String reply;

  const ChatBubbleWithReplyLine({
    Key? key,
    required this.username,
    required this.message,
    required this.timeAgo,
    required this.likes,
    required this.reply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 48.0, top: 8, bottom: 8),
          child: Row(
            children: [
              Text(
                timeAgo,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(width: 16),
              const Text("Like", style: TextStyle(color: Colors.blue)),
              const SizedBox(width: 16),
              const Text("Reply", style: TextStyle(color: Colors.blue)),
              const Spacer(),
              Text(likes.toString(),
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        // Reply Section with Line
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reply Line
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 8.0),
              child: Column(
                children: [
                  Container(
                    width: 2,
                    height: 24,
                    color: Colors.grey.shade400,
                  ),
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            // Reply Bubble
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  reply,
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class CommentInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Write a comment",
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              // Add logic for sending the comment
            },
            child: CircleAvatar(
              backgroundColor: Colors.teal,
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
