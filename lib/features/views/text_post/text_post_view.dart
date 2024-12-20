import 'package:connectify/common/buttons/custom_button.dart';
import 'package:connectify/common/utils/utils.dart';
import 'package:flutter/material.dart';

class TextPostScreen extends StatelessWidget {
  const TextPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your description here...',
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
              text: "Post",
            ),
          ],
        ),
      ),
    );
  }
}
