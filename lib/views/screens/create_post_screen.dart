import 'package:community_feed_app/utils/gradients.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  int _selectedGradientIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            // Add logic to close the screen
          },
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.black),
          ),
        ),
        title: const Text(
          'Create Post',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Add logic for creating a post
            },
            child: const Text(
              'Create',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text Input
            TextField(
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              maxLines: 5,
            ),

            // Color Selection Row
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: GradientResources.gradientsColor.length,
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() => _selectedGradientIndex = index),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: 50,
                        width: 25,
                        // Adjust the height as per your design
                        decoration: BoxDecoration(
                          gradient: GradientResources.gradientsColor[index],
                          border: Border.all(
                            color: _selectedGradientIndex == index
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(
                              8), // Optional for rounded corners
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
