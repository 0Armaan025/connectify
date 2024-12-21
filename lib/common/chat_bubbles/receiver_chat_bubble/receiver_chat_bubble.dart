import 'package:connectify/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _navigateToEnlargedImage(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnlargedImageView(imageUrl: imageUrl),
      ),
    );
  }

  void _playVideo(String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerView(
          videoUrl: videoUrl,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.videoUrl != null) {
      try {
        _controller =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!))
              ..initialize().then((_) {
                // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                setState(() {});
              }).catchError((error) {
                showSnackBar(context, error.toString());
              });
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
    _controller.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

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
              const SizedBox(height: 10),
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
    bool hasImage = widget.imageUrl != null;
    bool hasVideo = widget.videoUrl != null;

    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onLongPress: _showContextMenuDialog,
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
                          onTap: () =>
                              _navigateToEnlargedImage(widget.imageUrl!),
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
                          onTap: () => _playVideo(widget.videoUrl!),
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
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Icon(
                                  !_controller.value.isPlaying
                                      ? Icons.play_circle_fill
                                      : null,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (!hasImage && !hasVideo) ...[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Text(
                            _isExpanded
                                ? widget.message
                                : widget.message.length > 80
                                    ? '${widget.message.substring(0, 80)}...'
                                    : widget.message,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black87,
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
                      ],
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
      ),
    );
  }
}

class EnlargedImageView extends StatelessWidget {
  final String imageUrl;

  const EnlargedImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}

class VideoPlayerView extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerView({super.key, required this.videoUrl});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        }).catchError((error) {
          showSnackBar(context, error.toString());
        });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: Text('hi'),
              ),
      ),
    );
  }
}
