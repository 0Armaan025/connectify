import 'dart:io';

import 'package:connectify/common/utils.dart';
import 'package:connectify/pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/constants.dart';

class ProfileSetUpPage extends StatefulWidget {
  const ProfileSetUpPage({super.key});

  @override
  State<ProfileSetUpPage> createState() => _ProfileSetUpPageState();
}

class _ProfileSetUpPageState extends State<ProfileSetUpPage> {
  File? _imageFile;
  pickProfileImage(BuildContext context) {
    final size = MediaQuery.of(context).size;

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              decoration: BoxDecoration(
                color: Pallete().bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: BoxConstraints(maxHeight: size.height * 0.25),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        " Please pick the image source:",
                        style: GoogleFonts.poppins(
                          color: Pallete().headlineTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Camera",
                        style: GoogleFonts.poppins(
                          color: Pallete().headlineTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () async {
                        _imageFile =
                            await pickImage(context, ImageSource.camera);
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.browse_gallery,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Gallery",
                        style: GoogleFonts.poppins(
                          color: Pallete().headlineTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () async {
                        _imageFile =
                            await pickImage(context, ImageSource.camera);
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Pallete().bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Profile Setup',
                  style: GoogleFonts.poppins(
                    color: Pallete().headlineTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                    color: HexColor("#1f2326"),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey[700],
                            child: _imageFile != null
                                ? null
                                : Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!)
                                : null,
                          ),
                          Positioned(
                            top: size.height * 0.065,
                            right: 0,
                            left: size.width * 0.14,
                            child: IconButton(
                                onPressed: () {
                                  pickProfileImage(context);
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.green[500],
                                  weight: 800,
                                  size: 30,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: size.height * 0.08,
                        margin: const EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(top: 20),
                        decoration: BoxDecoration(
                          color: HexColor("#2a2c33"),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Icon(
                              Icons.alternate_email_rounded,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Your username",
                                  hintStyle: GoogleFonts.poppins(
                                    color: Colors.grey.shade500,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
