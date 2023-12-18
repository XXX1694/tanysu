import 'package:flutter/material.dart';
import 'package:tanysu/common/functions/show_snack_bar.dart';
import 'package:tanysu/common/widgets/main_button_filled.dart';
import 'package:tanysu/features/registration/presentation/pages/user_picture_page.dart';
import 'package:tanysu/features/registration/presentation/widgets/choose_partner_page/choose_partner_main.dart';
import 'package:tanysu/features/registration/presentation/widgets/choose_partner_page/partner_list.dart';

import 'package:tanysu/l10n/translate.dart';

class UserPartnerChoosePage extends StatefulWidget {
  const UserPartnerChoosePage({
    super.key,
    required this.birthday,
    required this.city,
    required this.email,
    required this.gender,
    required this.name,
    required this.password,
  });
  final String email;
  final String password;
  final String name;
  final String birthday;
  final String gender;
  final String city;
  @override
  State<UserPartnerChoosePage> createState() => _UserPartnerChoosePageState();
}

class _UserPartnerChoosePageState extends State<UserPartnerChoosePage> {
  late TextEditingController tryToFindController;

  @override
  void initState() {
    tryToFindController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const ChoosePartnerMain(),
              const SizedBox(height: 40),
              PartnerList(controller: tryToFindController),
              const Spacer(),
              MainButtonFilled(
                text: translation(context).next,
                onPressed: () {
                  tryToFindController.text.isNotEmpty
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserPicturePage(
                              birthday: widget.birthday,
                              city: widget.city,
                              email: widget.email,
                              gender: widget.gender,
                              name: widget.name,
                              password: widget.password,
                              tryToFind: tryToFindController.text,
                            ),
                          ),
                        )
                      : showSnackBar(
                          context, translation(context).choose_partner_main);
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
    tryToFindController.dispose();
    super.dispose();
  }
}
