import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/features/profile_add_info/presentation/pages/juz_page.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/about_me_widgets/about_me_field.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/about_me_widgets/about_me_main_text.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/about_me_widgets/about_me_second_text.dart';

import '../../../../core/constants/colors.dart';
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
      backgroundColor: Colors.white,
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: mainColor,
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
                width: deviceWidth * 3 / 4,
                height: 5,
                color: mainColor,
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
              const SizedBox(height: 60),
              const AboutMeMainText(),
              const SizedBox(height: 40),
              AboutMeField(controller: _aboutMeController),
              const SizedBox(height: 12),
              const AboutMeSecondText(),
              const Spacer(),
              MainButton(
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
                status: 'active',
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
