import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttatchmentTile extends StatefulWidget {
  const AttatchmentTile({super.key});

  @override
  State<AttatchmentTile> createState() => _AttatchmentTileState();
}

class _AttatchmentTileState extends State<AttatchmentTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(8).copyWith(top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.image,
              color: Colors.grey.shade800,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            'Attachment.png',
            style: GoogleFonts.poppins(
              color: Colors.grey.shade800,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
