import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/features/profile_add_info/presentation/pages/job_page.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/school_page_widgets/school_page_main_text.dart';
import 'package:tanysu/l10n/translate.dart';

import '../widgets/school_page_widgets/school_page_field.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key});

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  late TextEditingController _schoolNameController;
  @override
  void initState() {
    _schoolNameController = TextEditingController();
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
                  builder: (context) => const JobPage(
                    school: null,
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
                letterSpacing: -0.41,
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
                width: deviceWidth * 1 / 4,
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 36),
              const SchoolPageMainText(),
              const SizedBox(height: 32),
              SchoolPageField(controller: _schoolNameController),
              const Spacer(),
              MainButton(
                text: translation(context).next,
                onPressed: () {
                  if (_schoolNameController.text.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JobPage(
                          school: null,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobPage(
                          school: _schoolNameController.text,
                        ),
                      ),
                    );
                  }
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
    _schoolNameController.dispose();
    super.dispose();
  }
}
