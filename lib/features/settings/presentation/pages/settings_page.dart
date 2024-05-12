import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/functions/show_snack_bar.dart';
import 'package:tanysu/features/profile_page/presentation/bloc/profile_page_bloc.dart';
import 'package:tanysu/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tanysu/features/settings/presentation/widgets/change_language.dart';
import 'package:tanysu/l10n/translate.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsBloc bloc;
  late ProfilePageBloc profilePageBloc;
  @override
  void initState() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    profilePageBloc = BlocProvider.of<ProfilePageBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageBloc, ProfilePageState>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.black,
          title: Text(
            translation(context).settings,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leadingWidth: 40,
          leading: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                child: SvgPicture.asset(
                  'assets/icons/back_button.svg',
                  height: 24,
                  width: 24,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.black26,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        translation(context).theme,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {},
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1,
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        translation(context).language,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeLanguage(),
                      ),
                    );
                  },
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1,
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        translation(context).faq,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {},
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1,
                ),
                BlocConsumer<SettingsBloc, SettingsState>(
                  builder: (context, state) => CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translation(context).log_out,
                          style: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    onPressed: () {
                      bloc.add(UserLogOut());
                    },
                  ),
                  listener: (context, state) {
                    if (state is UserLoggedOut) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    }
                  },
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1,
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Удалить аккаунт',
                        style: GoogleFonts.montserrat(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        contentPadding: const EdgeInsets.all(20),
                        content: Text(
                          translation(context).are_you_sure,
                          textAlign: TextAlign.center,
                        ),
                        contentTextStyle: TextStyle(
                          color: secondColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              // Navigator.pop(context);

                              profilePageBloc.add(DeleteProfile());
                            },
                            child: Text(translation(context).yes),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(translation(context).no),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      listener: (BuildContext context, Object? state1) {
        if (state1 is ProfileDeleted) {
          showSnackBar(context, 'Аккаунт удалён!');
          bloc.add(UserLogOut());
        }
      },
    );
  }
}
