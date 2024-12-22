import 'package:connectify/common/chat_bubbles/receiver_chat_bubble/receiver_chat_bubble.dart';
import 'package:connectify/common/chat_bubbles/sender_chat_bubble/sender_chat_bubble.dart';
import 'package:connectify/common/utils/utils.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<Map<String, String>> _messages = [];
  final List<String> _placeholders = [
    "What do you feel like sharing?",
    "Got something on your mind?",
    "Say something cool!",
    "How's it going?",
    "Share a random thought..."
  ];

  String _currentPlaceholder = '';
  bool _isCustomKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _setRandomPlaceholder();
    // Adding initial dummy messages
    _messages.addAll([
      {
        "type": "sender",
        "name": "Armaan",
        "message": "Hi there Arnav, how are you?",
        "time": "22:03 PM IST",
      },
      {
        "type": "receiver",
        "name": "Arnav",
        "message":
            "Hi there Armaan, I'm cool, wbu? Amet sunt laborum est ut. Incididunt exercitation commodo ad esse anim anim qui enim. Qui est voluptate ullamco non esse irure consectetur laboris non amet velit est veniam. Lorem dolor ad occaecat veniam eu sint.",
        "time": "22:03 PM IST",
      },
    ]);
  }

  void _setRandomPlaceholder() {
    setState(() {
      _currentPlaceholder = _placeholders[
          (DateTime.now().millisecondsSinceEpoch % _placeholders.length)];
    });
  }

  void _addMessage(String message) {
    setState(() {
      _messages.add({
        "type": "sender",
        "name": "You",
        "message": message,
        "time": "${TimeOfDay.now().format(context)}",
      });
    });
  }

  void _toggleCustomKeyboard() {
    setState(() {
      _isCustomKeyboardVisible = !_isCustomKeyboardVisible;
      if (_isCustomKeyboardVisible) {
        _focusNode.unfocus();
      }
    });
  }

  Widget _buildCustomKeyboard() {
    return Container(
      height: 250,
      color: Colors.grey.shade200,
      child: GridView.count(
        crossAxisCount: 4,
        padding: const EdgeInsets.all(8),
        children: [
          ...['😊', '😂', '❤️', '👍', '🔥', '🎉', '🙏', '💯'].map((emoji) {
            return GestureDetector(
              onTap: () {
                _textController.text += emoji;
              },
              child: Center(
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            );
          }).toList(),
          ...['Hello!', 'Thanks!', 'Yes', 'No', 'Good job!'].map((text) {
            return GestureDetector(
              onTap: () {
                _textController.text += text;
              },
              child: Chip(
                label: Text(text),
                backgroundColor: Colors.blue.shade50,
              ),
            );
          }),
        ],
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Image"),
                onTap: () {
                  Navigator.pop(context);
                  // Handle image selection
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_camera_back),
                title: const Text("Video"),
                onTap: () {
                  Navigator.pop(context);
                  // Handle video selection
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showContextMenu(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final Offset position = overlay.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      constraints: BoxConstraints(
        minWidth: 200,
        maxWidth: 2000,
      ),
      position: RelativeRect.fromLTRB(
        position.dx + MediaQuery.of(context).size.width - 150,
        position.dy + 50,
        position.dx + MediaQuery.of(context).size.width - 20,
        position.dy + 150,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'report',
          child: Text('Report'),
        ),
        PopupMenuItem<String>(
          value: 'block',
          child: Text('Block'),
        ),
        PopupMenuItem<String>(
          value: 'clear_chat',
          child: Text('Clear Chat'),
        ),
        PopupMenuItem<String>(
          value: 'view_profile',
          child: Text('View Profile'),
        ),
      ],
      elevation: 1,
    ).then((value) {
      if (value != null) {
        // Handle the selected option here
        switch (value) {
          case 'report':
            // Handle report
            break;
          case 'block':
            // Handle block
            break;
          case 'clear_chat':
            // Handle clear chat
            break;
          case 'view_profile':
            // Handle view profile
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatAppBar(context, 'Arnav', 'Online', () {
        _showContextMenu(context);
      }),
      body: GestureDetector(
        onTap: () {
          // Dismiss custom keyboard if it's visible
          if (_isCustomKeyboardVisible) {
            setState(() {
              _isCustomKeyboardVisible = false;
            });
          }
          // Unfocus the TextField to hide the keyboard
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: _messages.map((message) {
                      if (message['type'] == 'sender') {
                        return SenderChatBubble(
                          senderName: message['name']!,
                          videoUrl:
                              'https://www.sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4',
                          message: message['message']!,
                          senderImage: '',
                          time: message['time']!,
                        );
                      } else {
                        return ReceiverChatBubble(
                          videoUrl:
                              'https://www.sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4',
                          senderName: message['name']!,
                          message: message['message']!,
                          senderImage: '',
                          time: message['time']!,
                        );
                      }
                    }).toList(),
                  ),
                ),
              ),
            ),
            if (_isCustomKeyboardVisible) _buildCustomKeyboard(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: _currentPlaceholder,
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                      ),
                      onTap: () {
                        // Dismiss custom keyboard if visible
                        if (_isCustomKeyboardVisible) {
                          setState(() {
                            _isCustomKeyboardVisible = false;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _openBottomSheet(context),
                    onLongPress: _toggleCustomKeyboard,
                    child: const Icon(
                      Icons.attach_file,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 22,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (_textController.text.trim().isNotEmpty) {
                          _addMessage(_textController.text.trim());
                          _textController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
