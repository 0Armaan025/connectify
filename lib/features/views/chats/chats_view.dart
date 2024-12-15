import 'package:connectify/common/navbar/custom_navbar.dart';
import 'package:connectify/common/utils.dart';
import 'package:flutter/material.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Text("Chats"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
