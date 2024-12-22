import 'package:connectify/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowersListPage extends StatefulWidget {
  const FollowersListPage({super.key});

  @override
  State<FollowersListPage> createState() => _FollowersListPageState();
}

class _FollowersListPageState extends State<FollowersListPage> {
  // Sample data for followers list
  final List<Follower> followers = [
    Follower(
      userName: 'Sam Smith',
      profilePicUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
      followsYou: true,
    ),
    Follower(
      userName: 'John Doe',
      profilePicUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
      followsYou: false,
    ),
    Follower(
      userName: 'Emily Johnson',
      profilePicUrl:
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
      followsYou: true,
    ),
    // Add more followers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: followers.length,
          itemBuilder: (context, index) {
            final follower = followers[index];

            return FollowerTile(follower: follower);
          },
        ),
      ),
    );
  }
}

class FollowerTile extends StatefulWidget {
  final Follower follower;

  const FollowerTile({required this.follower});

  @override
  _FollowerTileState createState() => _FollowerTileState();
}

class _FollowerTileState extends State<FollowerTile> {
  bool _isFollowing = false; // Track follow/unfollow state

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
              backgroundImage: NetworkImage(widget.follower.profilePicUrl),
            ),
            const SizedBox(width: 16),
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Name
                  Text(
                    widget.follower.userName,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Optional "Follows You" text
                  if (widget.follower.followsYou)
                    Text(
                      'Follows You',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.green,
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

class Follower {
  final String userName;
  final String profilePicUrl;
  final bool followsYou;

  Follower({
    required this.userName,
    required this.profilePicUrl,
    required this.followsYou,
  });
}
