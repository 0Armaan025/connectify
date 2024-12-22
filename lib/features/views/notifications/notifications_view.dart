import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      "type": "like",
      "user": "Armaan",
      "message": "liked your post",
      "time": "5 min ago",
    },
    {
      "type": "comment",
      "user": "Armaan",
      "message":
          'commented on your post saying "Hi, this is a great photo! Keep it up!"',
      "time": "10 min ago",
    },
    {
      "type": "follow",
      "user": "Armaan",
      "message": "followed you",
      "time": "1 hour ago",
    },
    {
      "type": "unfollow",
      "user": "Armaan",
      "message": "is not following you anymore",
      "time": "2 hours ago",
    },
    {
      "type": "post",
      "user": "Armaan",
      "message": "posted a new post, check it out!",
      "time": "Yesterday",
      "isFollowing": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationTile(
            type: notification["type"],
            user: notification["user"],
            message: notification["message"],
            time: notification["time"],
            isFollowing: notification["isFollowing"] ?? false,
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String type;
  final String user;
  final String message;
  final String time;
  final bool isFollowing;

  const NotificationTile({
    Key? key,
    required this.type,
    required this.user,
    required this.message,
    required this.time,
    this.isFollowing = false,
  }) : super(key: key);

  IconData _getIconForType(String type) {
    switch (type) {
      case "like":
        return Icons.favorite;
      case "comment":
        return Icons.comment;
      case "follow":
        return Icons.person_add;
      case "unfollow":
        return Icons.person_remove;
      case "post":
        return Icons.post_add;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case "like":
        return Colors.red;
      case "comment":
        return Colors.blue;
      case "follow":
        return Colors.green;
      case "unfollow":
        return Colors.orange;
      case "post":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _truncateMessage(String message) {
    const int maxLength = 30; // Limit to 30 words
    final words = message.split(" ");
    return words.length > maxLength
        ? "${words.sublist(0, maxLength).join(" ")}..."
        : message;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getIconColor(type).withOpacity(0.2),
          child: Icon(_getIconForType(type), color: _getIconColor(type)),
        ),
        title: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 14, color: Colors.black),
            children: [
              TextSpan(
                text: user,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: " "),
              TextSpan(text: _truncateMessage(message)),
            ],
          ),
        ),
        subtitle: Text(
          time,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: isFollowing
            ? ElevatedButton(
                onPressed: () {
                  // Action to view the new post
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.lightBlueAccent.shade100,
                ),
                child: Text(
                  "View",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                ),
              )
            : null,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NotificationsPage(),
  ));
}
