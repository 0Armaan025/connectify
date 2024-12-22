import 'package:connectify/common/profile_post_tile/profile_post_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final bool isOnline = true; // Indicates online status
  bool _isFollowed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                          ),
                        ),
                        if (isOnline)
                          Positioned(
                            bottom: 2,
                            right: 7,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Armaan",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.message, color: Colors.purple),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Icon(Icons.edit, color: Colors.purple),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isFollowed = !_isFollowed;
                                      });
                                    },
                                    child: Container(
                                      width: size.width * 0.24,
                                      height: size.height * 0.032,
                                      decoration: BoxDecoration(
                                        color: !_isFollowed
                                            ? Colors.purple
                                            : Colors.purpleAccent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        !_isFollowed ? "Follow" : "Unfollow",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "\" Lorem reprehenderit adipisicing adipisicing elit pariatur labore Lorem irure aliquip. Consectetur nulla ea minim esse voluptate reprehenderit in laborum adipisicing minim elit dolore. Qui incididunt commodo dolor ipsum. Ut adipisicing eiusmod non occaecat tempor laboris irure. \" ",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "250",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Following",
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "1.5k",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Followers",
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "5",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Likes",
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const PostWidget(
                          profilePicUrl:
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                          userName: 'John Doe',
                          postTime: '6 hours ago',
                          textContent: 'This is another post.',
                          videoUrl:
                              'https://example.com/sample-video-url', // Placeholder
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const PostWidget(
                          profilePicUrl:
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                          userName: 'John Doe',
                          postTime: '6 hours ago',
                          textContent: 'This is another post.',
                          videoUrl:
                              'https://example.com/sample-video-url', // Placeholder
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
