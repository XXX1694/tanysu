import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/like_page/presentation/pages/like_page.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'tanysu',
          style: GoogleFonts.montserratAlternates(
            color: mainColor,
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
              'assets/icons/notification.svg',
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
                header: ClassicHeader(
                  textStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                    letterSpacing: -0.41,
                  ),
                  idleText: translation(context).pull_to_refresh,
                  releaseText: translation(context).release_to_refresh,
                  refreshingText: translation(context).refreshing_text,
                ),
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: () async {
                  // await Future.delayed(const Duration(milliseconds: 500));
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
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: SizedBox(
                          width: double.infinity,
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            color: mainColor20,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LikePage(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Мои лайки',
                                  style: GoogleFonts.montserratAlternates(
                                    color: mainColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: mainColor20,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (state.model.likes ?? 0).toString(),
                                      style: GoogleFonts.montserratAlternates(
                                        color: mainColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
