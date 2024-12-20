import 'package:connectify/common/attatchment_tile/attatchment_tile.dart';
import 'package:connectify/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThreadView extends StatefulWidget {
  const ThreadView({super.key});

  @override
  State<ThreadView> createState() => _ThreadViewState();
}

class _ThreadViewState extends State<ThreadView> {
  final String forumContent =
      "How to create a forum post in Flutter and manage long texts effectively? This is an extended content version to check scrolling behavior when the word count exceeds the limit of 70 words. The goal is to make the UI user-friendly and visually appealing while keeping the main post accessible.";

  bool isExpanded = false;

  String _getTrimmedContent() {
    final contentWords = forumContent.split(" ");
    if (contentWords.length > 15 && !isExpanded) {
      return "${contentWords.sublist(0, 15).join(" ")}...";
    }
    return forumContent;
  }

  bool isContentScrollable = false;

  Widget _buildPostUserSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1498278854500-7c206daa073b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bW91bnRhaW58ZW58MHwxfDB8fHww',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Armaan",
                      style: GoogleFonts.poppins(color: Colors.grey.shade700),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "8 days ago",
                    style: GoogleFonts.poppins(color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getTrimmedContent(),
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (forumContent.split(" ").length > 40)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Text(
                            isExpanded ? "Read Less" : "Read More",
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade700,
                        radius: 20,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            CupertinoIcons.arrow_up_circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "28k",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AttatchmentTile(),
                  AttatchmentTile(),
                  AttatchmentTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCommentsSection() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return GestureDetector(
          onLongPress: () {
            void showOptionsDialog(BuildContext context) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.report),
                          title: const Text("Report Comment"),
                          onTap: () {
                            // Add logic to report the comment
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text("View Profile"),
                          onTap: () {
                            // Add logic to view the profile
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete),
                          title: const Text("Delete Comment"),
                          onTap: () {
                            // Add logic to delete the comment
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            showOptionsDialog(context);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1511367461989-f85a21fda167?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cGVyc29ufGVufDB8fDB8fHww',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User ${index + 1}",
                            style: GoogleFonts.poppins(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "This is comment ${index + 1} content. It's detailed and includes thoughtful insights.",
                            style: GoogleFonts.poppins(
                                color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade700,
                          radius: 14,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.arrow_up_circle,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${index * 10}",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Attachments Section
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      AttatchmentTile(),
                      AttatchmentTile(),
                      AttatchmentTile(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildCommentInputSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Leave a comment...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.image),
                          title: const Text("Image"),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.videocam),
                          title: const Text("Video"),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.cancel),
                          title: const Text("Cancel"),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: isContentScrollable
          ? SingleChildScrollView(
              child: Column(
                children: [
                  _buildPostUserSection(context),
                  _buildCommentsSection(),
                  _buildCommentInputSection(),
                ],
              ),
            )
          : Column(
              children: [
                _buildPostUserSection(context),
                Expanded(
                  child: ListView(
                    children: [
                      _buildCommentsSection(),
                    ],
                  ),
                ),
                _buildCommentInputSection(),
              ],
            ),
    );
  }
}
