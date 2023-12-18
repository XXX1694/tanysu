import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class ProfileAboutBlock extends StatelessWidget {
  const ProfileAboutBlock({
    super.key,
    required this.about,
    required this.city,
    required this.job,
    required this.ru,
    required this.study,
    required this.work,
  });
  final String city;
  final String work;
  final String study;
  final String about;
  final String job;
  final String ru;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        city != ''
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: translation(context).location_pr,
                      style: GoogleFonts.montserrat(
                        color: secondColor70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: city,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        city != '' ? const SizedBox(height: 12) : const SizedBox(),
        job != ''
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: translation(context).work_pr,
                      style: GoogleFonts.montserrat(
                        color: secondColor70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '$job, $work',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        job != '' ? const SizedBox(height: 12) : const SizedBox(),
        study != ''
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: translation(context).study_pr,
                      style: GoogleFonts.montserrat(
                        color: secondColor70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: study,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        study != '' ? const SizedBox(height: 12) : const SizedBox(),
        ru != ''
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ру: ',
                      style: GoogleFonts.montserrat(
                        color: secondColor70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ru,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        ru != '' ? const SizedBox(height: 12) : const SizedBox(),
        about != ''
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: translation(context).about_pr,
                      style: GoogleFonts.montserrat(
                        color: secondColor70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: about,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
