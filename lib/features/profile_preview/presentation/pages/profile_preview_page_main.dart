import 'dart:io';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/widgets/placeholers.dart';
import 'package:tanysu/features/block_user/presentation/widgets/show_block.dart';

import 'package:tanysu/features/profile_preview/presentation/bloc/profile_preview_bloc.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/follow_button.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_about.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_info_block.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/send_gift_button.dart';
import 'package:tanysu/l10n/translate.dart';

class ProfilePreviewPageMain extends StatefulWidget {
  const ProfilePreviewPageMain({
    super.key,
    required this.profileId,
    required this.controller,
  });
  final int profileId;
  final AppinioSwiperController? controller;

  @override
  State<ProfilePreviewPageMain> createState() => _ProfilePreviewPageMainState();
}

class _ProfilePreviewPageMainState extends State<ProfilePreviewPageMain> {
  late ProfilePreviewBloc bloc;
  String firstName = '';
  int id = 0;
  @override
  void initState() {
    bloc = BlocProvider.of<ProfilePreviewBloc>(context);
    bloc.add(GetUserData(userId: widget.profileId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const GradientText(
          'Tanysu',
          gradient: LinearGradient(
            colors: <Color>[
              mainColor,
              secondColor,
            ],
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              height: 24,
              width: 24,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/more.svg',
                  height: 15,
                ),
              ),
            ),
            onPressed: () {
              showBlockIOS(context, firstName, id);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ProfilePreviewBloc, ProfilePreviewState>(
          builder: (context, state) {
            if (state is ProfilePreviewDataGetting) {
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
            } else if (state is ProfilePreviewDataGot) {
              firstName = state.model.first_name ?? '';
              id = state.model.id ?? 0;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    CarouselSlider(
                      items: state.model.images!
                          .map(
                            (e) => Container(
                              // margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: double.infinity,
                              height: double.infinity,
                              // margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: e['image_url'],
                                  placeholder: (context, url) =>
                                      const ShrimerPlaceholder(
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const ErrorPlaceholder(
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayInterval: const Duration(seconds: 3),
                        height: 420,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '${state.model.first_name}, ${state.model.age}',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SvgPicture.asset(
                            'assets/icons/not_verified.svg',
                            height: 34,
                            width: 34,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          ProfileInfoBlockForSearch(
                            coins: 0,
                            followers: state.model.followers_count ?? 0,
                            isLiked: state.model.is_liked,
                            profileId: state.model.id ?? 0,
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: Colors.black26,
                            height: 1,
                          ),
                          const SizedBox(height: 20),
                          SendGiftButton(
                            userName: state.model.first_name ?? '',
                            profileId: state.model.id ?? 0,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FollowButton(
                                folloewed: state.model.subscribed,
                                profileId: state.model.id ?? 0,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ProfileAboutBlock(
                            about: state.model.about_me ?? '',
                            city: state.model.city_name ?? '',
                            job: state.model.profession ?? '',
                            ru: state.model.juz ?? '',
                            study: state.model.school_name ?? '',
                            work: state.model.company_name ?? '',
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(translation(context).error),
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
