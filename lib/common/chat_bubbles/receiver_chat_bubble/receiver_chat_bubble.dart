import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceiverChatBubble extends StatefulWidget {
  final String message;
  final String time;
  final String senderName;
  final String senderImage;

  const ReceiverChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.senderName,
    required this.senderImage,
  });

  @override
  State<ReceiverChatBubble> createState() => _ReceiverChatBubbleState();
}

class _ReceiverChatBubbleState extends State<ReceiverChatBubble> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String displayMessage = _isExpanded
        ? widget.message
        : widget.message.length > 80
            ? '${widget.message.substring(0, 80)}...'
            : widget.message;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(widget.senderImage),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.senderName,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        displayMessage,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (widget.message.length > 50 && !_isExpanded)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          "Read More",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      widget.time,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
