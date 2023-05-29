import 'package:flutter/material.dart';
import 'package:instagramclone/models/stories_model.dart';
import 'package:story_time/story_page_view/story_page_view.dart';

class StoryScreen extends StatelessWidget {
  final StoriesModel story;
  const StoryScreen({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: StoryPageView(
    itemBuilder: (context, pageIndex, storyIndex) {
      
      final image=story.images[storyIndex];
      return Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.black),
          ),
          Positioned.fill(
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 44, left: 8),
            child: Row(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(story.userimage),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  story.username,
                  style:const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
    gestureItemBuilder: (context, pageIndex, storyIndex) {
      return Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.white,
            icon:const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    },
    pageLength: story.images.length,
    indicatorDuration:const Duration(minutes: 1),
    storyLength: (int pageIndex) {
      return story.images.length;
    },
    onPageLimitReached: () {
      Navigator.pop(context);
    },
  ),
);
  }
}