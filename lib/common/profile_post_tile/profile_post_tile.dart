import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  final String profilePicUrl;
  final String userName;
  final String postTime;
  final String? textContent;
  final String? imageUrl;
  final String? videoUrl;
  final int likesCount;
  final int commentsCount;
  final String uploadDate;
  final String uploadTime;

  const PostWidget({
    super.key,
    required this.profilePicUrl,
    required this.userName,
    required this.postTime,
    this.textContent,
    this.imageUrl,
    this.videoUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.uploadDate,
    required this.uploadTime,
  });

  String _getPostTitle(String? textContent) {
    if (textContent == null || textContent.isEmpty) return "No Title";
    final words = textContent.split(' ');
    return words.length > 5 ? words.take(5).join(' ') + "..." : textContent;
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Post Details",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Post Title: ${_getPostTitle(textContent)}",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                "No. of Likes: $likesCount",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                "No. of Comments: $commentsCount",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                "Uploading Date: $uploadDate",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                "Uploading Time: $uploadTime",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                "Uploaded by: $userName",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Profile Picture + User Info + Post Time
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(profilePicUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        postTime,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.visibility_outlined),
                                title: const Text('View Post'),
                                onTap: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Viewed')),
                                  );
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.info_outline_rounded),
                                title: const Text('Details'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _showDetailsDialog(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                title: const Text('Delete Post'),
                                onTap: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Deleted')),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Text Content
            if (textContent != null)
              Text(
                textContent!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            // Image Content
            if (imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ],
            // Video Placeholder (or use an actual video player)
            if (videoUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.black12,
                  height: 200,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.play_circle_outline,
                    size: 50,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
