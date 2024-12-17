import 'package:connectify/common/comment_tile/comment_tile.dart';
import 'package:connectify/common/enlarged_image/enlarged_image_view.dart';
import 'package:connectify/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isFollowed = false;

  _showComments(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        isScrollControlled: true,
        transitionAnimationController: AnimationController(
          vsync: Navigator.of(context),
          duration: const Duration(milliseconds: 300),
        ),
        context: context,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        builder: (context) {
          return Container(
            height: size.height * 0.86,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          CupertinoIcons.back,
                          color: Colors.grey.shade700,
                          size: 35,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Comments",
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade800, fontSize: 22),
                      ),
                    ],
                  ),
                  CommentTile(),
                ],
              ),
            ),
          );
        });
  }

  _openEnlargedImage(BuildContext context) {
    moveScreen(
      context,
      EnlargedImageView(
          imageUrl:
              'https://images.unsplash.com/photo-1498278854500-7c206daa073b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bW91bnRhaW58ZW58MHwxfDB8fHww'),
    );
  }

  void showCustomReasonDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Specify Reason",
            style: GoogleFonts.poppins(),
          ),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              hintText: "Enter your reason",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dismiss dialog
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                final reason = reasonController.text.trim();
                if (reason.isNotEmpty) {
                  print("Reported with reason: $reason");
                }
                Navigator.pop(context); // Dismiss dialog
              },
              child: Text(
                "Submit",
                style: GoogleFonts.poppins(color: Colors.purple),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                height: size.height * 0.36,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.delete,
                        color: Colors.red,
                      ),
                      title: Text(
                        "Delete",
                        style: GoogleFonts.poppins(),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Confirm Action",
                                style: GoogleFonts.poppins(),
                              ),
                              content: Text(
                                "Are you sure you want to delete this content?",
                                style: GoogleFonts.poppins(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Dismiss dialog
                                  },
                                  child: Text(
                                    "Cancel",
                                    style:
                                        GoogleFonts.poppins(color: Colors.grey),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Dismiss dialog
                                  },
                                  child: Text(
                                    "Delete",
                                    style:
                                        GoogleFonts.poppins(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.chart_bar,
                        color: Colors.purple,
                      ),
                      title: Text(
                        "View Insights",
                        style: GoogleFonts.poppins(),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.purple,
                      ),
                      title: Text(
                        "User profile",
                        style: GoogleFonts.poppins(),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.minus_circle,
                        color: Colors.purple,
                      ),
                      title: Text(
                        "Block user",
                        style: GoogleFonts.poppins(),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.flag,
                        color: Colors.purple,
                      ),
                      title: Text(
                        "Report content",
                        style: GoogleFonts.poppins(),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(14)
                                    .copyWith(left: 2, right: 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Report Content",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ListTile(
                                      title: Text("Harassment",
                                          style: GoogleFonts.poppins()),
                                      onTap: () {
                                        // Handle report submission for Harassment
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                    ListTile(
                                      title: Text("Bullying",
                                          style: GoogleFonts.poppins()),
                                      onTap: () {
                                        // Handle report submission for Bullying
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                    ListTile(
                                      title: Text("Spam",
                                          style: GoogleFonts.poppins()),
                                      onTap: () {
                                        // Handle report submission for Spam
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                    ListTile(
                                      title: Text("Other",
                                          style: GoogleFonts.poppins()),
                                      onTap: () {
                                        // Show a text input for custom reason
                                        Navigator.pop(context);
                                        showCustomReasonDialog(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _openEnlargedImage(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                height: size.height * 0.57,
                decoration: const BoxDecoration(
                  // color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1498278854500-7c206daa073b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bW91bnRhaW58ZW58MHwxfDB8fHww',
                    ),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: size.width * 0.01,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/128/3177/3177440.png'),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Armaan",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              // follow button here
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _isFollowed = !_isFollowed;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  width: !_isFollowed
                                      ? size.width * 0.18
                                      : size.width * 0.28,
                                  height: size.height * 0.03,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _isFollowed
                                        ? HexColor("#87CEEB")
                                        : HexColor("#e1e2e3"),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: !_isFollowed
                                      ? Text(
                                          "Follow",
                                          style: GoogleFonts.poppins(),
                                        )
                                      : Text("Followed ✔️",
                                          style: GoogleFonts.poppins()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              // padding: const EdgeInsets.all(8).copyWith(bottom: 12, top: 12),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 7),
                        child: Column(
                          children: [
                            LikeButton(
                              size: 30,
                              circleColor: CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.favorite,
                                  color: isLiked
                                      ? Colors.red.shade800
                                      : Colors.grey,
                                  size: 30,
                                );
                              },
                              likeCount: 665,
                              countBuilder:
                                  (int? count, bool isLiked, String text) {
                                var color = isLiked
                                    ? Colors.deepPurpleAccent
                                    : Colors.grey;
                                Widget? result;
                                if (count == 0) {
                                  result = Text(
                                    "love",
                                    style: TextStyle(color: color),
                                  );
                                } else {
                                  result = Text(
                                    text,
                                    style: TextStyle(color: color),
                                  );
                                }
                                return result;
                              },
                              countPostion: CountPostion.bottom,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 7),
                        child: GestureDetector(
                          onTap: () {
                            _showComments(context);
                          },
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.chat_bubble_2,
                                color: Colors.grey.shade700,
                              ),
                              Text(
                                "14K",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 7, right: 12),
                    child: GestureDetector(
                      onTap: () {
                        Share.share('check out my website https://example.com',
                            subject: 'Look what I made!');
                      },
                      child: Column(
                        children: [
                          Icon(
                            CupertinoIcons.share,
                            color: Colors.grey.shade700,
                          ),
                          Text(
                            "14K",
                            style: GoogleFonts.poppins(
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
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
}
