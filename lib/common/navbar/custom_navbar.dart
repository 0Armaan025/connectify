import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BuildNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BuildNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 2,
            activeColor: Colors.black,
            iconSize: 25,
            tabBorderRadius: 12,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 200),
            color: Colors.black,
            tabs: [
              GButton(
                icon: selectedIndex == 0
                    ? CupertinoIcons.house_fill
                    : CupertinoIcons.house,
                iconColor: Colors.grey[800],
                iconActiveColor: Colors.grey[900],
              ),
              GButton(
                icon: selectedIndex == 1 ? Icons.forum : Icons.forum_outlined,
                iconColor: Colors.grey[800],
                iconActiveColor: Colors.grey[900],
              ),
              GButton(
                icon: selectedIndex == 2
                    ? CupertinoIcons.chat_bubble_2_fill
                    : CupertinoIcons.chat_bubble_2,
                iconColor: Colors.grey[800],
                iconActiveColor: Colors.grey[900],
              ),
              GButton(
                icon: selectedIndex == 3
                    ? CupertinoIcons.person_fill
                    : CupertinoIcons.person,
                iconColor: Colors.grey[800],
                iconActiveColor: Colors.grey[900],
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
