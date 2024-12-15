import 'dart:io';

import 'package:connectify/constants/constants.dart';
import 'package:connectify/pallete/pallete.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

final Connectivity connectivity = Connectivity();
bool isInternet = false;

void moveScreen(BuildContext context, Widget screen,
    {bool isPushReplacement = false}) {
  if (isPushReplacement) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

Future<File?> pickImage(BuildContext context, ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedImage = await picker.pickImage(source: source);

  if (pickedImage != null) {
    File image = File(pickedImage.path);

    return image;
  } else {
    showSnackBar(context, "Please choose an image!");
    return null;
  }

  return null;
}

// let's just return the image then

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: HexColor("#e0e0de"),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.add_circled),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.search),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
          icon: const Icon(CupertinoIcons.bell),
          onPressed: () {},
        ),
      ),
    ],
    title: Text(
      "Connectify",
      style: GoogleFonts.gloriaHallelujah(),
    ),
  );
}
