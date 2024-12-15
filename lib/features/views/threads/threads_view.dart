import 'package:connectify/common/navbar/custom_navbar.dart';
import 'package:connectify/common/utils.dart';
import 'package:flutter/material.dart';

class ThreadsView extends StatefulWidget {
  const ThreadsView({super.key});

  @override
  State<ThreadsView> createState() => _ThreadsViewState();
}

class _ThreadsViewState extends State<ThreadsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Text("Threads"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
