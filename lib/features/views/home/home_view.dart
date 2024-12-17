import 'dart:async';

import 'package:connectify/common/navbar/custom_navbar.dart';
import 'package:connectify/common/utils.dart';
import 'package:connectify/constants/constants.dart';
import 'package:connectify/features/views/chats/chats_view.dart';
import 'package:connectify/features/views/home/home_page_content.dart';
import 'package:connectify/features/views/profile/profile_view.dart';
import 'package:connectify/features/views/threads/threads_view.dart';
import 'package:connectify/pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? _sub;
  int navBarIndex = 0;

  final bgColor = Pallete().bgColor;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  Future<void> _handleIncomingLinks() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleLink(initialLink);
      }

      _sub = linkStream.listen((String? link) {
        if (link != null) {
          _handleLink(link);
        }
      });
    } catch (e) {
      debugPrint('Error handling links: $e');
    }
  }

  void _handleLink(String link) {
    final uri = Uri.parse(link);

    if (uri.pathSegments.contains('post')) {
      final postId = uri.pathSegments.last;
      Navigator.pushNamed(context, '/post', arguments: postId);
    } else {
      debugPrint('Unhandled link: $link');
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
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
