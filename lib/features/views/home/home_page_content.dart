import 'package:connectify/common/navbar/custom_navbar.dart';
import 'package:connectify/common/utils.dart';
import 'package:flutter/material.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Text("Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
