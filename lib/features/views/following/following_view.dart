import 'package:connectify/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowingListPage extends StatefulWidget {
  const FollowingListPage({super.key});

  @override
  State<FollowingListPage> createState() => _FollowingListPageState();
}

class _FollowingListPageState extends State<FollowingListPage> {
  // Sample data for the following list
  final List<Following> following = [
    Following(
      userName: 'Alice Brown',
      profilePicUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
      isFollowing: true,
    ),
    Following(
      userName: 'Jack White',
      profilePicUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
      isFollowing: true,
    ),
    Following(
      userName: 'Rachel Green',
      profilePicUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
      isFollowing: false,
    ),
    // More users they are following
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: following.length,
          itemBuilder: (context, index) {
            final follow = following[index];
            return FollowingTile(follow: follow);
          },
        ),
      ),
    );
  }
}

class FollowingTile extends StatefulWidget {
  final Following follow;

  const FollowingTile({required this.follow});

  @override
  _FollowingTileState createState() => _FollowingTileState();
}

class _FollowingTileState extends State<FollowingTile> {
  bool _isFollowing = true; // Track follow/unfollow state for "Following" list

  @override
  Widget build(BuildContext context) {
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
              backgroundImage: NetworkImage(widget.follow.profilePicUrl),
            ),
            const SizedBox(width: 16),
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Name
                  Text(
                    widget.follow.userName,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // "Following" text if they are following the user
                  if (widget.follow.isFollowing)
                    Text(
                      'Following',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
            ),
            // Follow/Unfollow Button
            InkWell(
              onTap: () {
                setState(() {
                  _isFollowing = !_isFollowing;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: _isFollowing ? Colors.purpleAccent : Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _isFollowing ? 'Unfollow' : 'Follow',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Following {
  final String userName;
  final String profilePicUrl;
  final bool isFollowing; // Track if they are following the user or not

  Following({
    required this.userName,
    required this.profilePicUrl,
    required this.isFollowing,
  });
}
