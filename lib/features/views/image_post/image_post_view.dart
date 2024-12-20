import 'package:connectify/common/buttons/custom_button.dart';
import 'package:connectify/common/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePostScreen extends StatefulWidget {
  const ImagePostScreen({super.key});

  @override
  State<ImagePostScreen> createState() => _ImagePostScreenState();
}

class _ImagePostScreenState extends State<ImagePostScreen> {
  File? _selectedImage;
  final _descriptionController = TextEditingController();

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
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DottedBorder(
              color: Colors.grey,
              strokeWidth: 1.5,
              dashPattern: const [6],
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              child: SizedBox(
                height: 150,
                child: _selectedImage == null
                    ? IconButton(
                        icon: const Icon(
                          Icons.add_photo_alternate,
                          size: 40,
                          color: Colors.deepPurple,
                        ),
                        onPressed: _pickImage,
                      )
                    : GestureDetector(
                        onTap: _pickImage,
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: 3,
              controller: _descriptionController,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: 'Add a description (max 100 words)',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButtonWidget(
              text: "Post! :D",
            ),
          ],
        ),
      ),
    );
  }
}
