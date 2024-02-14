import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tanysu/common/constants/colors.dart';
import 'package:tanysu/features/block_user/presentation/widgets/show_block.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';

import 'package:tanysu/features/profile_preview/presentation/bloc/profile_preview_bloc.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_about.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_info_block.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/send_gift_button.dart';

class ProfilePreviewPage extends StatefulWidget {
  const ProfilePreviewPage({
    super.key,
    required this.profile,
    required this.controller,
  });
  final ProfileModel profile;
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
    _controller = AppinioSwiperController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.black12,
          ),
        ),
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
                widget.profile.first_name ?? '',
                widget.profile.id ?? 0,
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
                items: widget.profile.images!
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
                            loadingBuilder: (context, child, loadingProgress) {
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
                    '${widget.profile.first_name}, ${widget.profile.age}',
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
                      followers: widget.profile.followers_count ?? 0,
                      controller: widget.controller ?? _controller,
                      isLiked: widget.profile.is_liked,
                      profileId: widget.profile.id ?? 0,
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
                      userName: widget.profile.first_name ?? '',
                      profileId: widget.profile.id ?? 0,
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Colors.black26),
                    const SizedBox(height: 12),
                    ProfileAboutBlock(
                      about: widget.profile.about_me ?? '',
                      city: widget.profile.city_name ?? '',
                      job: widget.profile.profession ?? '',
                      ru: widget.profile.juz ?? '',
                      study: widget.profile.school_name ?? '',
                      work: widget.profile.company_name ?? '',
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
  }
}
