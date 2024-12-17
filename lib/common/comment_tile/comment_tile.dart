import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CommentTile extends StatefulWidget {
  const CommentTile({super.key});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool _isExpanded = false;
  final int maxWordsLength = 50;
  String commentText =
      "Dolor dolor mollit excepteur sunt Nostrud eiusmod nulla in excepteu Culpa eu cupidatat laborum exercitation ullamco esse enim qui ex aliqua minim eu. Culpa in eiusmod in ut et quis consectetur laboris laborum veniam ullamco nostrud aute est. Eu Lorem nisi proident esse dolor eiusmod amet. Tempor tempor duis magna reprehenderit occaecat esse magna exercitation. Aliqua occaecat et do cillum cillum tempor deserunt. labore ea anim duis exercitation excepteur dolore culpa nulla. Laboris ut amet ullamco cupidatat voluptate esse duis qui ullamco ad magna. Irure deserunt reprehenderit ad enim magna aliquip laborum laborum aute magna. Lorem excepteur ea incididunt mollit occaecat veniam esse.eprehenderit occaecat. Laboris irure exercitation incididunt ex ullamco quis in. Commodo duis tempor est deserunt culpa eiusmod consequat amet minim culpa dolor qui occaecat. Qui id et eiusmod nostrud do ex labore eu duis. Commodo ex reprehenderit id elit in eiusmod ad nisi incididunt. Fugiat ex culpa aliquip esse elit culpa ad aliquip velit exercitation Lorem. Laborum commodo irure cillum ipsum magna culpa elit consectetur tempor reprehenderit consequat eiusmod.";

  String displayedText = ""; // Store the text to display
  bool _isLongText = false;

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        );
      },
    );
  }

  Widget contentBox(context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Report Comment'),
            onTap: () {
              Navigator.pop(context);
              _handleReport();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('View User Profile'),
            onTap: () {
              Navigator.pop(context);
              _handleViewProfile();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text('Delete comment'),
            onTap: () {
              Navigator.pop(context);
              _handleViewProfile();
            },
          ),
          TextButton(
            // Add a cancel button
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  void _handleReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Comment reported')),
    );
  }

  void _handleViewProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Viewing user profile')),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCommentText();
  }

  void _getCommentText() {
    final words = commentText.split(' ');
    _isLongText = words.length > maxWordsLength;

    displayedText = _isLongText
        ? words.take(maxWordsLength).join(' ') + '...'
        : commentText;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showOptionsDialog(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/128/3135/3135715.png'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '2 hours ago',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: LikeButton(
                    size: 30,
                    circleColor: const CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.red.shade800 : Colors.grey,
                        size: 30,
                      );
                    },
                    likeCount: 665,
                    countBuilder: (int? count, bool isLiked, String text) {
                      var color =
                          isLiked ? Colors.deepPurpleAccent : Colors.grey;
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
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _isExpanded
                  ? commentText
                  : displayedText, // Use displayedText here
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
            if (_isLongText)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Read Less' : 'Read More',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue), // Make it blue for better visibility
                ),
              ),
          ],
        ),
      ),
    );
  }
}
