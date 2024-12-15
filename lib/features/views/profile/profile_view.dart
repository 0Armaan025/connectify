import 'package:connectify/common/navbar/custom_navbar.dart';
import 'package:connectify/common/utils.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Text("Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
