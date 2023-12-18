import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/widgets/main_button_filled.dart';
import 'package:tanysu/features/profile_add_info/presentation/pages/about_me_page.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/job_page_widgets/company_field.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/job_page_widgets/job_field.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/job_page_widgets/job_page_main_text.dart';

import '../../../../common/constants/colors.dart';
import '../../../../l10n/translate.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key, required this.school});
  final String? school;
  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  late TextEditingController _jobController;
  late TextEditingController _companyController;
  @override
  void initState() {
    _jobController = TextEditingController();
    _companyController = TextEditingController();
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
                  builder: (context) => AboutMePage(
                    company: null,
                    job: null,
                    school: widget.school,
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
                width: deviceWidth * 2 / 6,
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
              const SizedBox(height: 36),
              const JobPageMainText(),
              const SizedBox(height: 32),
              JobField(controller: _jobController),
              const SizedBox(height: 20),
              CompanyField(controller: _companyController),
              const Spacer(),
              MainButtonFilled(
                text: translation(context).next,
                onPressed: () {
                  if (_jobController.text.isEmpty &&
                      _companyController.text.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutMePage(
                          company: null,
                          job: null,
                          school: widget.school,
                        ),
                      ),
                    );
                  } else if (_jobController.text.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutMePage(
                          company: _companyController.text,
                          job: null,
                          school: widget.school,
                        ),
                      ),
                    );
                  } else if (_companyController.text.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutMePage(
                          company: null,
                          job: _jobController.text,
                          school: widget.school,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutMePage(
                          company: _companyController.text,
                          job: _jobController.text,
                          school: widget.school,
                        ),
                      ),
                    );
                  }
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
    _jobController.dispose();
    _companyController.dispose();
    super.dispose();
  }
}
