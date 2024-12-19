import 'package:connectify/common/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddForumPostView extends StatefulWidget {
  const AddForumPostView({super.key});

  @override
  State<AddForumPostView> createState() => _AddForumPostViewState();
}

class _AddForumPostViewState extends State<AddForumPostView> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: size.height * 0.42,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(),
                  child: DottedBorder(
                    color: Colors.grey,
                    strokeWidth: 1.5,
                    dashPattern: [6],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _selectedImage == null
                              ? IconButton(
                                  icon: Icon(
                                    Icons.add_photo_alternate,
                                    size: 40,
                                    color: Colors.deepPurple,
                                  ),
                                  onPressed: _pickImage,
                                )
                              : Text(''),
                          const SizedBox(height: 10),
                          _selectedImage != null
                              ? Image.file(
                                  _selectedImage!,
                                  width: double.infinity,
                                  height: size.height * 0.34,
                                  fit: BoxFit.fill,
                                )
                              : const Text(
                                  'No image selected',
                                  style: TextStyle(color: Colors.grey),
                                ),
                        ],
                      ),
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
