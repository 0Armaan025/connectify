import 'package:connectify/common/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class SenderChatBubble extends StatefulWidget {
  final String message;
  final String time;
  final String senderName;
  final String senderImage;
  final bool isSeen;
  final String? imageUrl;
  final String? videoUrl;
  final ScrollController scrollController;

  const SenderChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.senderName,
    required this.senderImage,
    this.isSeen = false,
    this.imageUrl,
    this.videoUrl,
    required this.scrollController,
  });

  @override
  State<SenderChatBubble> createState() => _SenderChatBubbleState();
}

class _SenderChatBubbleState extends State<SenderChatBubble> {
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
              showSnackBar(context, error.toString());
            });
      _controller.play();
    }

    // Scroll to the latest message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController
          .jumpTo(widget.scrollController.position.maxScrollExtent);
    });
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

  TextSpan _buildTextWithLinks(String text) {
    final urlPattern = RegExp(r'https?:\/\/[^\s]+');
    final matches = urlPattern.allMatches(text);

    if (matches.isEmpty) {
      return TextSpan(
        text: text,
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
      );
    }

    final spans = <TextSpan>[];
    int currentIndex = 0;

    for (final match in matches) {
      if (currentIndex < match.start) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
        ));
      }

      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _launchUrl(text.substring(match.start, match.end)),
      ));

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
      ));
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    bool hasImage = widget.imageUrl != null;
    bool hasVideo = widget.videoUrl != null;

    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onLongPress: () {
          // Add context menu functionality here
        },
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
                      if (hasImage)
                        GestureDetector(
                          onTap: () {
                            // Navigate to enlarged image view
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
                            // Play video in a new screen
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: _controller.value.isInitialized
                                    ? AspectRatio(
                                        aspectRatio:
                                            _controller.value.aspectRatio,
                                        child: VideoPlayer(_controller),
                                      )
                                    : Container(),
                              ),
                              if (!_controller.value.isPlaying)
                                const Positioned.fill(
                                  child: Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                            ],
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
                            text: _buildTextWithLinks(
                              _isExpanded
                                  ? widget.message
                                  : widget.message.length > 80
                                      ? '${widget.message.substring(0, 80)}...'
                                      : widget.message,
                            ),
                          ),
                        ),
                      if (widget.message.length > 80 && !_isExpanded)
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
