import 'package:connectify/common/utils.dart';
import 'package:connectify/features/views/thread/thread_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ForumPost extends StatefulWidget {
  const ForumPost({super.key});

  @override
  State<ForumPost> createState() => _ForumPostState();
}

class _ForumPostState extends State<ForumPost> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onLongPress: () {
        // show delete , report and show profile options in a modal container / dialog anything you feel is fine
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: Colors.white,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      Icons.report,
                      color: Colors.red,
                    ),
                    title: const Text('Report post'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    title: const Text('Delete post'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  )
                ],
              ),
            );
          },
        );
      },
      onTap: () {
        moveScreen(context, const ThreadView());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: HexColor("#dedede"),
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // User Info
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
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Text(
                    "8 days ago",
                    style: GoogleFonts.poppins(color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Forum Post Text with Wrapping and Truncation
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    _truncateText(
                        "How to create a forum post in Flutter and manage long texts effectively?"),
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
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
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _truncateText(String text) {
    const int maxWords = 70;
    List<String> words = text.split(' ');

    if (words.length > maxWords) {
      return '${words.sublist(0, maxWords).join(' ')}...';
    }
    return text;
  }
}
