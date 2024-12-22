import 'dart:io';
import 'dart:typed_data';

import 'package:connectify/features/views/notifications/notifications_view.dart';
import 'package:connectify/features/views/post_upload/post_upload_view.dart';
import 'package:connectify/features/views/search_users/search_users_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
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

    // Compress the image
    File? compressedImage = await compressImage(image);
    return compressedImage;
  } else {
    showSnackBar(context, "Please choose an image!");
    return null;
  }
}

Future<File?> pickMedia(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedMedia = await picker.pickMedia();

  if (pickedMedia != null) {
    File image = File(pickedMedia.path);

    // Compress the image
    File? compressedImage = await compressImage(image);
    return compressedImage;
  } else {
    showSnackBar(context, "Please choose an image!");
    return null;
  }
}

Future<File?> compressImage(File image) async {
  final Uint8List? result = await FlutterImageCompress.compressWithFile(
    image.absolute.path,
    minWidth: 800, // Minimum width (can be adjusted)
    minHeight: 600, // Minimum height (can be adjusted)
    quality: 80, // Image quality (can be adjusted)
    rotate: 0, // Rotation (if needed)
  );

  if (result!.isNotEmpty) {
    // Write the compressed bytes to a new file
    File compressedFile = File(image.path)..writeAsBytesSync(result);
    return compressedFile;
  } else {
    print("Compression failed.");
    return null;
  }
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
          onPressed: () {
            moveScreen(context, const PostUploadView());
          },
          icon: const Icon(CupertinoIcons.add_circled),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
          onPressed: () {
            moveScreen(context, SearchUsersView());
          },
          icon: const Icon(CupertinoIcons.search),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
          icon: const Icon(CupertinoIcons.bell),
          onPressed: () {
            moveScreen(context, NotificationsPage());
          },
        ),
      ),
    ],
    title: Text(
      "Connectify",
      style: GoogleFonts.gloriaHallelujah(),
    ),
  );
}

buildChatAppBar(BuildContext context, String username, String status,
    VoidCallback threeDotPressed) {
  return AppBar(
    backgroundColor: HexColor("#e0e0de"),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.video_camera),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.phone),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
          icon: const Icon(CupertinoIcons.ellipsis_vertical),
          onPressed: threeDotPressed,
        ),
      ),
    ],
    title: Row(
      children: [
        Stack(
          clipBehavior: Clip.none, // To allow the green dot to overflow
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://imgs.search.brave.com/2Yc0aaN4QdY-5vJhCd2mh6WLIm_qkuVmRWKWOkxn43o/rs:fit:32:32:1:0/g:ce/aHR0cDovL2Zhdmlj/b25zLnNlYXJjaC5i/cmF2ZS5jb20vaWNv/bnMvNmRlZGE0MGIz/YjQ3NzBjNzZlNzll/OTk5MmM4YWViYmRm/MWU2ZGYxZDAwNGZh/N2EyOGNjYTc3NjFl/MDMzZDc1MS93d3cu/a3Vtb3NwYWNlLmNv/bS8'),
            ),
            if (status.toLowerCase() == "online")
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              status,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
