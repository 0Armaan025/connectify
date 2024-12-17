import 'dart:io';

import 'package:connectify/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostUploadView extends StatefulWidget {
  const PostUploadView({super.key});

  @override
  State<PostUploadView> createState() => PostUploadViewState();
}

class PostUploadViewState extends State<PostUploadView> {
  File? mediaFile;

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
                  String filePath = mediaFile?.path ?? 'No path';

                  if (filePath == 'No path') {
                    showSnackBar(
                        context, 'Please pick again, an error happened');
                  }

                  final String extension =
                      filePath.split('.').last.toLowerCase();

                  bool _isFine = false;

                  switch (extension) {
                    case 'jpg':
                    case 'jpeg':
                    case 'png':
                    case 'gif':
                    case 'mp4':
                    case 'mov':
                    case 'avi':
                      _isFine = true;
                      break;
                    default:
                      _isFine = false;
                      break;
                  }

                  setState(() {
                    if (_isFine) {
                      mediaFile = mediaFile;
                    } else {
                      mediaFile = null;
                      showSnackBar(context, 'Invalid file format');
                    }
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.green),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);

                  mediaFile = await pickMedia(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.forum, color: Colors.blue),
                title: const Text('Forum'),
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
