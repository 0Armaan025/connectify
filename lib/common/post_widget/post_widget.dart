import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
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
            decoration: InputDecoration(
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
                  // Handle the reason submission here
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
                                    // Perform delete action here
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
                      leading: Icon(
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
                      leading: Icon(
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
                      leading: Icon(
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
                      leading: Icon(
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
            Container(
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
                        CircleAvatar(
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
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.only(top: 2),
                                width: size.width * 0.22,
                                height: size.height * 0.03,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: HexColor("#87CEEB"),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text("Follow"),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8).copyWith(bottom: 12, top: 12),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Text("hi"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
