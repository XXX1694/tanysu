import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class PartnerList extends StatefulWidget {
  const PartnerList({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<PartnerList> createState() => _PartnerListState();
}

int selected = 4;

class _PartnerListState extends State<PartnerList> {
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
              border: Border.all(
                color: selected == 0 ? secondColor : Colors.black45,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                translation(context).woman,
                style: GoogleFonts.montserrat(
                  color: selected == 0 ? secondColor : Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              if (selected != 0) {
                selected = 0;
                widget.controller.text = 'female';
              } else {
                selected = 4;
                widget.controller.text = '';
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
              border: Border.all(
                color: selected == 1 ? secondColor : Colors.black45,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                translation(context).man,
                style: GoogleFonts.montserrat(
                  color: selected == 1 ? secondColor : Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              if (selected != 1) {
                selected = 1;
                widget.controller.text = 'male';
              } else {
                selected = 4;
                widget.controller.text = '';
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
              border: Border.all(
                color: selected == 2 ? secondColor : Colors.black45,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                translation(context).everyone,
                style: GoogleFonts.montserrat(
                  color: selected == 2 ? secondColor : Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              if (selected != 2) {
                selected = 2;
                widget.controller.text = 'null';
              } else {
                selected = 4;
                widget.controller.text = '';
              }
            });
          },
        ),
      ],
    );
  }
}
