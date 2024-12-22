import 'package:connectify/common/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LikesView extends StatefulWidget {
  const LikesView({super.key});

  @override
  State<LikesView> createState() => _LikesViewState();
}

class _LikesViewState extends State<LikesView> {
  // Sample data for the posts
  final List<Post> posts = [
    Post(
      userName: 'Sam Smith',
      profilePicUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
      postText:
          'This is a sample post text that should be truncated after a certain number of characters to fit the UI design.',
      likes: 250,
    ),
    Post(
      userName: 'John Doe',
      profilePicUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
      postText: 'Short post text!',
      likes: 120,
    ),
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            return PostTile(post: post);
          },
        ),
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    // Truncate the text to 30 characters
    String truncatedText = post.postText.length > 30
        ? '${post.postText.substring(0, 30)}...'
        : post.postText;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // User Image
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(post.profilePicUrl),
            ),
            const SizedBox(width: 16),
            // User info and video text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Name
                  Text(
                    post.userName,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Video Text
                  Text(
                    truncatedText,
                    style: GoogleFonts.poppins(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Likes Count
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.heart_fill, color: Colors.red.shade500),
                const SizedBox(height: 4),
                Text(
                  '${post.likes}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String userName;
  final String profilePicUrl;
  final String postText;
  final int likes;

  Post({
    required this.userName,
    required this.profilePicUrl,
    required this.postText,
    required this.likes,
  });
}
