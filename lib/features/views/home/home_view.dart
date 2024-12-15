import 'package:connectify/common/navbar/custom_navbar.dart';
import 'package:connectify/common/utils.dart';
import 'package:connectify/constants/constants.dart';
import 'package:connectify/features/views/chats/chats_view.dart';
import 'package:connectify/features/views/home/home_page_content.dart';
import 'package:connectify/features/views/profile/profile_view.dart';
import 'package:connectify/features/views/threads/threads_view.dart';
import 'package:connectify/pallete/pallete.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navBarIndex = 0;

  final bgColor = Pallete().bgColor;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: BuildNavBar(
        selectedIndex: navBarIndex,
        onTabChange: (index) {
          setState(() {
            navBarIndex = index;
          });
        },
      ),
      body: _getSelectedPage(navBarIndex),
    );
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return const HomePageContent();
      case 1:
        return const ThreadsView();
      case 2:
        return const ChatsView();
      case 3:
        return const ProfileView();
      default:
        return const HomePageContent();
    }
  }
}
