import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.black,
          centerTitle: true,
          title: Text(
            translation(context).settings,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                ),
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
                const SizedBox(height: 8),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        translation(context).theme,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {},
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        translation(context).language,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
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
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        translation(context).faq,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {},
                ),
                BlocConsumer<SettingsBloc, SettingsState>(
                  builder: (context, state) => CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translation(context).log_out,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
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
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Удалить аккаунт',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        iconPadding: const EdgeInsets.all(8),
                        contentPadding: const EdgeInsets.all(8),
                        insetPadding: const EdgeInsets.all(12),
                        titlePadding: const EdgeInsets.all(16),
                        buttonPadding: const EdgeInsets.all(12),
                        actionsPadding: const EdgeInsets.all(4),
                        content: Text(
                          translation(context).are_you_sure,
                          textAlign: TextAlign.center,
                        ),
                        contentTextStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.black),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              // Navigator.pop(context);

                              profilePageBloc.add(DeleteProfile());
                            },
                            child: Text(
                              translation(context).yes,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: mainColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              translation(context).no,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.black),
                            ),
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
          showSnackBar(context, text: 'Аккаунт удалён!');
          bloc.add(UserLogOut());
        }
      },
    );
  }
}
