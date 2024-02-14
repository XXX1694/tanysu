import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/profile_page/presentation/bloc/profile_page_bloc.dart';
import 'package:tanysu/features/profile_page/presentation/widgets/coins_block.dart';
import 'package:tanysu/features/profile_page/presentation/widgets/name_block.dart';
import 'package:tanysu/features/profile_page/presentation/widgets/photo_block.dart';
import 'package:tanysu/features/profile_page/presentation/widgets/user_main_info.dart';
import 'package:tanysu/l10n/translate.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfilePageBloc bloc;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    bloc = BlocProvider.of<ProfilePageBloc>(context);
    bloc.add(GetMyData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'tanysu',
          style: GoogleFonts.montserrat(
            color: secondColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        surfaceTintColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/notification');
            },
            child: SvgPicture.asset(
              'assets/icons/ring.svg',
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
            child: SvgPicture.asset(
              'assets/icons/settings.svg',
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(width: 20),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.black12,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
          builder: (context, state) {
            if (state is ProfileGetting) {
              return Center(
                child: Platform.isAndroid
                    ? CircularProgressIndicator(
                        color: secondColor,
                        strokeWidth: 3,
                      )
                    : CupertinoActivityIndicator(
                        color: secondColor,
                      ),
              );
            } else if (state is ProfileGot) {
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 500));
                  bloc.add(GetMyData());
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      PhotoBlock(profile: state.model),
                      const SizedBox(height: 16),
                      NameBlock(
                        name: state.model.first_name ?? '',
                        age: state.model.age ?? 0,
                      ),
                      const SizedBox(height: 20),
                      UserMainInfo(
                        followers: state.model.followers_count ?? 0,
                        coins: 0,
                      ),
                      const SizedBox(height: 28),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Divider(color: Colors.black26),
                      ),
                      const SizedBox(height: 16),
                      const CoinsBlock(coins: 0),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(translation(context).something),
              );
            }
          },
        ),
      ),
    );
  }
}