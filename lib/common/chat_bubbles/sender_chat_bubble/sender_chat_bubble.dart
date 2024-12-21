import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SenderChatBubble extends StatefulWidget {
  final String message;
  final String time;
  final String senderName;
  final String senderImage;
  final bool isSeen;

  const SenderChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.senderName,
    required this.senderImage,
    this.isSeen = false,
  });

  @override
  State<SenderChatBubble> createState() => _SenderChatBubbleState();
}

class _SenderChatBubbleState extends State<SenderChatBubble> {
  bool _isExpanded = false;

  void _showContextMenuDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Menu",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(Icons.copy, size: 24),
                title: const Text(
                  'Copy message',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  size: 24,
                  color: Colors.red.shade500,
                ),
                title: const Text(
                  'Delete(for everyone)',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  size: 24,
                ),
                title: const Text(
                  'Details',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayMessage = _isExpanded
        ? widget.message
        : widget.message.length > 80
            ? '${widget.message.substring(0, 80)}...'
            : widget.message;

    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onLongPress: _showContextMenuDialog,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.time,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.isSeen ? "Seen" : "Sent",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: widget.isSeen ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(widget.senderImage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
