import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

bool followed = false;

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: 30,
        width: 125,
        decoration: BoxDecoration(
          color: followed ? Colors.black26 : accentColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            followed ? 'Unfollow' : 'Follow',
            style: GoogleFonts.montserrat(
              color: followed ? Colors.black : Colors.white,
              fontSize: 14,
              fontWeight: followed ? FontWeight.w400 : FontWeight.w600,
            ),
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          followed = !followed;
        });
      },
    );
  }
}
