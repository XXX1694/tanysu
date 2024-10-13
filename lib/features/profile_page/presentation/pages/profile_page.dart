import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/profile_page/presentation/bloc/profile_page_bloc.dart';
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
        title: const GradientText(
          'Tanysu',
          gradient: LinearGradient(
            colors: <Color>[
              mainColor,
              secondColor,
            ],
          ),
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: [
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              height: 24,
              width: 24,
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            child: SvgPicture.asset(
              'assets/icons/settings.svg',
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
          builder: (context, state) {
            if (state is ProfileGetting) {
              return Center(
                child: Platform.isAndroid
                    ? const CircularProgressIndicator(
                        color: mainColor,
                        strokeWidth: 3,
                      )
                    : const CupertinoActivityIndicator(
                        color: mainColor,
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
                      const SizedBox(height: 40),
                      PhotoBlock(profile: state.model),
                      const SizedBox(height: 20),
                      NameBlock(
                        name: state.model.first_name ?? '',
                        age: state.model.age ?? 0,
                      ),
                      const SizedBox(height: 20),
                      UserMainInfo(
                        followers: state.model.followers_count ?? 0,
                        likes: state.model.likes ?? 0,
                        followeings: state.model.following_count ?? 0,
                        newLikes: state.model.new_likes ?? 0,
                      ),
                      const SizedBox(height: 20),
                      // CoinsBlock(
                      //   coins: 0,
                      //   userName: state.model.first_name ?? '',
                      // )
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

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserratAlternates(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
