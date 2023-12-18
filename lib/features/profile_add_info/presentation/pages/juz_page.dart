import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/common/widgets/main_button_filled.dart';
import 'package:tanysu/features/edit_profile/presentation/widgets/juz_field.dart';
import 'package:tanysu/features/juz/presentation/bloc/juz_bloc.dart';
import 'package:tanysu/features/profile_add_info/presentation/bloc/profile_add_info_bloc.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/juz_page_widgets/juz_page_main_text.dart';
import 'package:tanysu/l10n/translate.dart';

class JuzPage extends StatefulWidget {
  const JuzPage({
    super.key,
    required this.school,
    required this.job,
    required this.company,
    required this.aboutMe,
  });
  final String? school;
  final String? job;
  final String? company;
  final String? aboutMe;
  @override
  State<JuzPage> createState() => _JuzPageState();
}

class _JuzPageState extends State<JuzPage> {
  late TextEditingController _juzController;
  late ProfileAddInfoBloc bloc;
  late JuzBloc bloc1;
  @override
  void initState() {
    bloc = BlocProvider.of<ProfileAddInfoBloc>(context);
    bloc1 = BlocProvider.of<JuzBloc>(context);
    // bloc1.add(GetAllJuz());
    _juzController = TextEditingController();
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
              bloc.add(
                AddInfoProfile(
                  aboutMe: widget.aboutMe,
                  company: widget.company,
                  job: widget.job,
                  school: widget.school,
                  juz: null,
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
                width: deviceWidth * 5 / 6,
                height: 5,
                color: accentColor,
              ),
            ],
          ),
        ),
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
      ),
      body: BlocConsumer<JuzBloc, JuzState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const JuzPageMainText(),
                  // const SizedBox(height: 20),
                  // const JuzPageSecondText(),
                  const SizedBox(height: 24),
                  JuzField(controller: _juzController),
                  const Spacer(),
                  BlocConsumer<ProfileAddInfoBloc, ProfileAddInfoState>(
                    builder: (context, state) {
                      if (state is AddingProfileInfo) {
                        return const MainButtonFilledLoading();
                      } else {
                        return MainButtonFilled(
                          text: translation(context).next,
                          onPressed: () {
                            bloc.add(
                              AddInfoProfile(
                                aboutMe: widget.aboutMe,
                                company: widget.company,
                                job: widget.job,
                                school: widget.school,
                                juz: _juzController.text,
                              ),
                            );
                          },
                        );
                      }
                    },
                    listener: (context, state) {
                      if (state is AddedProfileInfo) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/main', (route) => false);
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  @override
  void dispose() {
    _juzController.dispose();
    super.dispose();
  }
}
