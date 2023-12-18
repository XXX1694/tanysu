import 'dart:io';

import 'package:appinio_swiper/controllers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/block_user/presentation/widgets/show_block.dart';

import 'package:tanysu/features/profile_preview/presentation/bloc/profile_preview_bloc.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_about.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_info_block.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/send_gift_button.dart';
import 'package:tanysu/l10n/translate.dart';

class ProfilePreviewPage extends StatefulWidget {
  const ProfilePreviewPage({
    super.key,
    required this.profileId,
    required this.controller,
  });
  final int profileId;
  final AppinioSwiperController? controller;

  @override
  State<ProfilePreviewPage> createState() => _ProfilePreviewPageState();
}

class _ProfilePreviewPageState extends State<ProfilePreviewPage> {
  late ProfilePreviewBloc bloc;
  late AppinioSwiperController _controller;
  @override
  void initState() {
    bloc = BlocProvider.of<ProfilePreviewBloc>(context);
    bloc.add(GetUserData(userId: widget.profileId));
    _controller = AppinioSwiperController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePreviewBloc, ProfilePreviewState>(
      builder: (context, state) {
        if (state is ProfilePreviewDataGetting) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Platform.isAndroid
                        ? CircularProgressIndicator(
                            color: secondColor,
                            strokeWidth: 3,
                          )
                        : CupertinoActivityIndicator(
                            color: secondColor,
                          ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ProfilePreviewDataGot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'tanysu',
                style: GoogleFonts.montserrat(
                  color: secondColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              foregroundColor: Colors.black,
              surfaceTintColor: Colors.black,
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
                    showBlock(
                      context,
                      state.model.first_name ?? '',
                      state.model.id ?? 0,
                    );
                  },
                )
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
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
                              width: 310,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  e['image_url'],
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.black,
                                  ),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Shimmer.fromColors(
                                        baseColor: secondColor,
                                        highlightColor: mainColor,
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.white,
                                        ),
                                      );
                                    }
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: 405,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.model.first_name}, ${state.model.age}',
                          style: GoogleFonts.montserrat(
                            color: secondColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        SvgPicture.asset(
                          'assets/icons/not_verified.svg',
                          height: 34,
                          width: 34,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(color: Colors.black26),
                          const SizedBox(height: 12),
                          ProfileInfoBlock(
                            coins: 0,
                            followers: state.model.followers_count ?? 0,
                            controller: widget.controller ?? _controller,
                          ),
                          const SizedBox(height: 12),
                          const Divider(color: Colors.black26),
                          // const SizedBox(height: 12),
                          // const Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     FollowButton(),
                          //   ],
                          // ),
                          const SizedBox(height: 12),
                          SendGiftButton(
                              userName: state.model.first_name ?? ''),
                          const SizedBox(height: 12),
                          const Divider(color: Colors.black26),
                          const SizedBox(height: 12),
                          ProfileAboutBlock(
                            about: state.model.about_me ?? '',
                            city: state.model.city_name ?? '',
                            job: state.model.profession ?? '',
                            ru: '',
                            study: state.model.school_name ?? '',
                            work: state.model.company_name ?? '',
                          ),
                          const SizedBox(height: 12),
                          const Divider(color: Colors.black26),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(translation(context).error),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
