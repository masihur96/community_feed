import 'package:community_feed_app/utils/app_color.dart';
import 'package:community_feed_app/utils/gradients.dart';
import 'package:community_feed_app/utils/screen_size.dart';
import 'package:community_feed_app/viewmodels/post_viewmodel.dart';
import 'package:community_feed_app/widgets/feed_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'feed_screen.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  int? _selectedGradientIndex;
  final _formKey = GlobalKey<FormState>();
  bool _isColorExpand = true;
  bool _isSubmitting = false;

  String _post = "";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black, // Black background for the status bar
        statusBarIconBrightness:
            Brightness.dark, // Black icons for the status bar
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            // Add logic to close the screen
          },
          child: Text(
            'Close',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: FeedColors.feedGrey),
          ),
        ),
        title: Text(
          'Create Post',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              createPost();
              // Add logic for creating a post
            },
            child: Text(
              'Create',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: FeedColors.likeColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text Input

            Form(
              key: _formKey,
              child: FeedTextFormField(
                maxLines: 5,
                hintText: "What's on your mind?",
                fillColor: FeedColors.feedWhite,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Field is empty"; // No error when the field is empty
                  }

                  return null;
                },
                onSaved: (String? value) {
                  _post = value!;
                },
              ),
            ),

            // Color Selection Row
            SizedBox(
              height: 55,
              width: screenSize(context, 1),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _isColorExpand = !_isColorExpand;
                      // _selectedGradientIndex = index;
                    }),
                    child: Container(
                      width: 30,
                      // Adjust the height as per your design
                      decoration: BoxDecoration(
                        color: FeedColors.feedWhite,
                        borderRadius: BorderRadius.circular(
                            4), // Optional for rounded corners
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  !_isColorExpand
                      ? SizedBox()
                      : Expanded(
                          child: ListView.builder(
                            itemCount: GradientResources.gradientsColor.length,
                            padding: const EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => setState(
                                    () => _selectedGradientIndex = index),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: 30,
                                    // Adjust the height as per your design
                                    decoration: BoxDecoration(
                                      gradient: GradientResources
                                          .gradientsColor[index],
                                      border: Border.all(
                                        color: _selectedGradientIndex != null &&
                                                _selectedGradientIndex == index
                                            ? Colors.blue
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          4), // Optional for rounded corners
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
          ],
        ),
      ),
    );
  }

  createPost() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String? bgColor;
      setState(() {
        _isSubmitting = true;
      });
      PostViewModel postViewModel = PostViewModel();

      if (_selectedGradientIndex != null) {
        // Get background color
        bgColor = GradientResources
            .feedBackGroundGradientColors[_selectedGradientIndex!];
      }

      print(bgColor);

      // Call API
      bool? success =
          await postViewModel.createFeed(post: _post, bgColor: bgColor);

      setState(() {
        _isSubmitting = false;
      });

      if (success != null && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post created successfully!')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => FeedScreen()),
          (Route<dynamic> route) => false,
        ); // Return to feed screen with success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create post')),
        );
      }
    }
  }
}
