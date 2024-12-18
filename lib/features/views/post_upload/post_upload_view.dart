import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class PostUploadView extends StatefulWidget {
  const PostUploadView({super.key});

  @override
  State<PostUploadView> createState() => PostUploadViewState();
}

class PostUploadViewState extends State<PostUploadView> {
  File? mediaFile;

  Future<File?> pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      File image = File(pickedImage.path);

      // Compress the image
      return await compressImage(image);
    } else {
      showSnackBar(context, "Please choose an image!");
      return null;
    }
  }

  Future<File?> pickMedia(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedMedia = await picker.pickMedia();

    if (pickedMedia != null) {
      File media = File(pickedMedia.path);
      return media;
    } else {
      showSnackBar(context, "Please choose a media file!");
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

    if (result != null) {
      File compressedFile = File(image.path)..writeAsBytesSync(result);
      return compressedFile;
    } else {
      print("Compression failed.");
      return null;
    }
  }

  void showOptionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose an Option',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.deepPurple),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);

                  mediaFile = await pickImage(context, ImageSource.camera);
                  if (mediaFile == null) {
                    showSnackBar(
                        context, 'An error occurred. Please try again.');
                  } else {
                    final String extension =
                        mediaFile!.path.split('.').last.toLowerCase();
                    if (_isValidMediaFile(extension)) {
                      setState(() {});
                    } else {
                      mediaFile = null;
                      showSnackBar(context, 'Invalid file format');
                    }
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.green),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);

                  mediaFile = await pickMedia(context);
                  if (mediaFile != null) {
                    final String extension =
                        mediaFile!.path.split('.').last.toLowerCase();
                    if (_isValidMediaFile(extension)) {
                      setState(() {});
                    } else {
                      mediaFile = null;
                      showSnackBar(context, 'Invalid file format');
                    }
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.forum, color: Colors.blue),
                title: const Text('Forum'),
                onTap: () async {
                  Navigator.pop(context);
                  // Handle Forum option here
                  // we will handle the forum post later on
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isValidMediaFile(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'mp4':
      case 'mov':
      case 'avi':
        return true;
      default:
        return false;
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Post'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.75,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      showOptionDialog(context);
                    },
                    icon: const Icon(Icons.upload_file, size: 45),
                  ),
                ),
              ),
              mediaFile != null
                  ? Image.file(mediaFile!)
                  : const SizedBox
                      .shrink(), // Show the selected image if available
            ],
          ),
        ),
      ),
    );
  }
}
