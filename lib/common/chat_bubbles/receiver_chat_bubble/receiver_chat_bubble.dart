import 'package:connectify/common/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ReceiverChatBubble extends StatefulWidget {
  final String message;
  final String time;
  final String senderName;
  final String senderImage;
  final String? imageUrl; // Optional field for image
  final String? videoUrl; // Optional field for video

  const ReceiverChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.senderName,
    required this.senderImage,
    this.imageUrl,
    this.videoUrl,
  });

  @override
  State<ReceiverChatBubble> createState() => _ReceiverChatBubbleState();
}

class _ReceiverChatBubbleState extends State<ReceiverChatBubble> {
  bool _isExpanded = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!))
            ..initialize().then((_) {
              setState(() {});
            }).catchError((error) {
              debugPrint("Error initializing video: $error");
            });
    }
  }

  @override
  void dispose() {
    if (widget.videoUrl != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      showSnackBar(context, 'Invalid link');
    }
  }

  List<TextSpan> _parseMessage(String message) {
    final urlPattern = RegExp(
      r'(https?:\/\/[^\s]+)',
      caseSensitive: false,
    );
    final matches = urlPattern.allMatches(message);
    if (matches.isEmpty) {
      return [TextSpan(text: message)];
    }

    final spans = <TextSpan>[];
    int lastIndex = 0;

    for (final match in matches) {
      final String before = message.substring(lastIndex, match.start);
      if (before.isNotEmpty) {
        spans.add(TextSpan(text: before));
      }
      final String url = message.substring(match.start, match.end);
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
        ),
      );
      lastIndex = match.end;
    }

    final String after = message.substring(lastIndex);
    if (after.isNotEmpty) {
      spans.add(TextSpan(text: after));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = widget.imageUrl != null;
    final bool hasVideo = widget.videoUrl != null;

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
                    if (hasImage)
                      GestureDetector(
                        onTap: () {
                          // Handle image tap
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (hasVideo)
                      GestureDetector(
                        onTap: () {
                          // Handle video tap
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _controller.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ),
                    if (!hasImage && !hasVideo)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.black87),
                            children: _parseMessage(widget.message),
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
