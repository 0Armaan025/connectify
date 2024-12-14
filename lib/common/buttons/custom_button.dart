import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomButtonWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final String text;
  final Color bgColor;
  final Color textColor;
  final double fontSize;
  final VoidCallback? onPressed;
  const CustomButtonWidget(
      {super.key,
      this.height,
      this.width,
      this.text = "Continue...",
      this.bgColor = const Color.fromRGBO(47, 49, 56, 1),
      this.textColor = Colors.white,
      this.onPressed,
      this.fontSize = 16});

  @override
  State<CustomButtonWidget> createState() => CustomButtonWidgetState();
}

class CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final height = widget.height ?? size.height * 0.08;

    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: height,
        width: widget.width ?? double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.bgColor,
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: GoogleFonts.poppins(
            color: widget.textColor,
            fontSize: widget.fontSize,
          ),
        ),
      ),
    );
  }
}
