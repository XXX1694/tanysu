import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class CardList extends StatefulWidget {
  const CardList({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CardList> createState() => _CardListState();
}

int index = 0;

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                if (index == 1) {
                  index = 0;
                } else {
                  index = 1;
                }
                widget.controller.text = translation(context).long_term;
                setState(() {});
              },
              child: Container(
                height: deviceHeight * 0.18,
                width: deviceWidth * 0.25,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: index == 1 ? Colors.white : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: index == 1 ? accentColor : Colors.transparent,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      translation(context).long_term,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                if (index == 2) {
                  index = 0;
                } else {
                  index = 2;
                }
                widget.controller.text = translation(context).long_term_s;
                setState(() {});
              },
              child: Container(
                height: deviceHeight * 0.18,
                width: deviceWidth * 0.25,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: index == 2 ? Colors.white : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: index == 2 ? accentColor : Colors.transparent,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      translation(context).long_term_s,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                if (index == 3) {
                  index = 0;
                } else {
                  index = 3;
                }
                widget.controller.text = translation(context).short_term_l;
                setState(() {});
              },
              child: Container(
                height: deviceHeight * 0.18,
                width: deviceWidth * 0.25,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: index == 3 ? Colors.white : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: index == 3 ? accentColor : Colors.transparent,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      translation(context).short_term_l,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                if (index == 4) {
                  index = 0;
                } else {
                  index = 4;
                }
                widget.controller.text = translation(context).short_term;
                setState(() {});
              },
              child: Container(
                height: deviceHeight * 0.18,
                width: deviceWidth * 0.25,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: index == 4 ? Colors.white : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: index == 4 ? accentColor : Colors.transparent,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      translation(context).short_term,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                if (index == 5) {
                  index = 0;
                } else {
                  index = 5;
                }
                widget.controller.text = translation(context).new_friends;
                setState(() {});
              },
              child: Container(
                height: deviceHeight * 0.18,
                width: deviceWidth * 0.25,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: index == 5 ? Colors.white : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: index == 5 ? accentColor : Colors.transparent,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      translation(context).new_friends,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                if (index == 6) {
                  index = 0;
                } else {
                  index = 6;
                }
                widget.controller.text = translation(context).still;
                setState(() {});
              },
              child: Container(
                height: deviceHeight * 0.18,
                width: deviceWidth * 0.25,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: index == 6 ? Colors.white : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: index == 6 ? accentColor : Colors.transparent,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      translation(context).still,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
