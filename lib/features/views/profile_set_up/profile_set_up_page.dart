import 'dart:io';

import 'package:animate_do/animate_do.dart'; // Import animate_do package
import 'package:connectify/common/buttons/custom_button.dart';
import 'package:connectify/common/utils/utils.dart';
import 'package:connectify/pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

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
                        "Please pick the image source:",
                        style: GoogleFonts.poppins(
                          color: Pallete().headlineTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
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
                      leading: const Icon(
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
                            await pickImage(context, ImageSource.gallery);
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
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: Center(
                  child: Text(
                    'Profile Setup',
                    style: GoogleFonts.poppins(
                      color: Pallete().headlineTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ZoomIn(
                duration: const Duration(milliseconds: 800),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: size.height * 0.72,
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
                        BounceInDown(
                          duration: const Duration(milliseconds: 800),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.grey[700],
                                backgroundImage: _imageFile != null
                                    ? FileImage(_imageFile!)
                                    : null,
                                child: _imageFile != null
                                    ? null
                                    : Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey[300],
                                        ),
                                      ),
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          duration: const Duration(milliseconds: 800),
                          child: Container(
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInRight(
                          duration: const Duration(milliseconds: 800),
                          child: Container(
                            width: double.infinity,
                            height: size.height * 0.25,
                            margin: const EdgeInsets.symmetric(horizontal: 20)
                                .copyWith(top: 20),
                            decoration: BoxDecoration(
                              color: HexColor("#2a2c33"),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: TextField(
                                      maxLines: null, // Allows multiline input
                                      expands:
                                          true, // Makes the TextField fill the available height
                                      textAlignVertical: TextAlignVertical
                                          .top, // Aligns text to the top
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Your bio",
                                        hintStyle: GoogleFonts.poppins(
                                          color: Colors.grey.shade500,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomButtonWidget(
                          onPressed: () {},
                        ),
                      ],
                    ),
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
