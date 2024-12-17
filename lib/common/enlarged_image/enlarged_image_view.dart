import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnlargedImageView extends StatefulWidget {
  final String imageUrl;
  const EnlargedImageView({super.key, required this.imageUrl});

  @override
  State<EnlargedImageView> createState() => _EnlargedImageViewState();
}

class _EnlargedImageViewState extends State<EnlargedImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
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
