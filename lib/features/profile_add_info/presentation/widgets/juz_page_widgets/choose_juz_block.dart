import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class ChooseJuzBlock extends StatefulWidget {
  const ChooseJuzBlock({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<ChooseJuzBlock> createState() => _ChooseJuzBlockState();
}

int juz = 5;

class _ChooseJuzBlockState extends State<ChooseJuzBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: juz == 1 ? secondColor : Colors.black54,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                translation(context).ulu_juz,
                style: GoogleFonts.montserrat(
                  color: juz == 1 ? secondColor : Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          onPressed: () {
            widget.controller.text = translation(context).ulu_juz;
            setState(() {
              if (juz != 1) {
                juz = 1;
              } else {
                juz = 5;
              }
            });
          },
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: juz == 2 ? secondColor : Colors.black54,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                translation(context).orta_juz,
                style: GoogleFonts.montserrat(
                  color: juz == 2 ? secondColor : Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          onPressed: () {
            widget.controller.text = translation(context).orta_juz;
            setState(() {
              if (juz != 2) {
                juz = 2;
              } else {
                juz = 5;
              }
            });
          },
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: juz == 3 ? secondColor : Colors.black54,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                translation(context).kishi_juz,
                style: GoogleFonts.montserrat(
                  color: juz == 3 ? secondColor : Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          onPressed: () {
            widget.controller.text = translation(context).kishi_juz;
            setState(() {
              if (juz != 3) {
                juz = 3;
              } else {
                juz = 5;
              }
            });
          },
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: juz == 4 ? secondColor : Colors.black54,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                translation(context).other,
                style: GoogleFonts.montserrat(
                  color: juz == 4 ? secondColor : Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          onPressed: () {
            widget.controller.text = 'Нет';
            setState(() {
              if (juz != 4) {
                juz = 4;
              } else {
                juz = 5;
              }
            });
          },
        ),
      ],
    );
  }
}
