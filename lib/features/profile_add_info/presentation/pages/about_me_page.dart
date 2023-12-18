import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/widgets/main_button_filled.dart';
import 'package:tanysu/features/profile_add_info/presentation/pages/juz_page.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/about_me_widgets/about_me_field.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/about_me_widgets/about_me_main_text.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/about_me_widgets/about_me_second_text.dart';

import '../../../../common/constants/colors.dart';
import '../../../../l10n/translate.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({
    super.key,
    required this.school,
    required this.job,
    required this.company,
  });
  final String? school;
  final String? job;
  final String? company;
  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  late TextEditingController _aboutMeController;

  @override
  void initState() {
    _aboutMeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          CupertinoButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JuzPage(
                    school: widget.school,
                    job: widget.job,
                    company: widget.company,
                    aboutMe: null,
                  ),
                ),
              );
            },
            child: Text(
              translation(context).skip,
              style: GoogleFonts.montserrat(
                color: secondColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 5,
                color: Colors.black26,
              ),
              Container(
                width: deviceWidth * 4 / 6,
                height: 5,
                color: accentColor,
              ),
            ],
          ),
        ),
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const AboutMeMainText(),
              const SizedBox(height: 20),
              AboutMeField(controller: _aboutMeController),
              const SizedBox(height: 20),
              const AboutMeSecondText(),
              const Spacer(),
              MainButtonFilled(
                text: translation(context).next,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JuzPage(
                        school: widget.school,
                        job: widget.job,
                        company: widget.company,
                        aboutMe: _aboutMeController.text,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _aboutMeController.dispose();
    super.dispose();
  }
}
