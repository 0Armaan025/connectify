import 'package:connectify/common/utils/utils.dart';
import 'package:connectify/features/views/chat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatTile extends StatefulWidget {
  final String username;
  final String status; // Add status as a parameter
  const ChatTile({
    super.key,
    required this.username,
    required this.status,
  });

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        moveScreen(context, ChatView());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none, // To allow the green dot to overflow
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: const NetworkImage(
                          'https://imgs.search.brave.com/2Yc0aaN4QdY-5vJhCd2mh6WLIm_qkuVmRWKWOkxn43o/rs:fit:32:32:1:0/g:ce/aHR0cDovL2Zhdmlj/b25zLnNlYXJjaC5i/cmF2ZS5jb20vaWNv/bnMvNmRlZGE0MGIz/YjQ3NzBjNzZlNzll/OTk5MmM4YWViYmRm/MWU2ZGYxZDAwNGZh/N2EyOGNjYTc3NjFl/MDMzZDc1MS93d3cu/a3Vtb3NwYWNlLmNv/bS8'),
                    ),
                    if (widget.status.toLowerCase() == "online")
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 8),

                // Chat Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Name
                          Text(
                            widget.username, // Use the passed username
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),

                          // Time
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "12:00 PM", // Time can also be passed or dynamically fetched
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Message Preview
                            Expanded(
                              child: Text(
                                "Random text.....", // Message preview can also be passed or dynamically fetched
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),

                            // Status
                            Text(
                              "Seen", // Status can also be dynamic (e.g., "Seen" or "Delivered")
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.blueGrey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
