import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/widgets/placeholers.dart';
import 'package:tanysu/features/block_user/presentation/widgets/show_block.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';

import 'package:tanysu/features/profile_preview/presentation/bloc/profile_preview_bloc.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_about.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_info_block.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/send_gift_button.dart';

import '../../../../core/constants/colors.dart';
import '../widgets/follow_button.dart';

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
              showBlockIOS(
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
                        width: double.infinity,
                        height: double.infinity,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        '${widget.profile.first_name}, ${widget.profile.age}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                        overflow: TextOverflow.ellipsis,
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
                    ProfileInfoBlock(
                      coins: 0,
                      followers: widget.profile.followers_count ?? 0,
                      controller: widget.controller ?? _controller,
                      isLiked: widget.profile.is_liked,
                      profileId: widget.profile.id ?? 0,
                    ),
                    const SizedBox(height: 20),
                    SendGiftButton(
                      userName: widget.profile.first_name ?? '',
                      profileId: widget.profile.id ?? 0,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FollowButton(
                          folloewed: widget.profile.subscribed,
                          profileId: widget.profile.id ?? 0,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ProfileAboutBlock(
                      about: widget.profile.about_me ?? '',
                      city: widget.profile.city_name ?? '',
                      job: widget.profile.profession ?? '',
                      ru: widget.profile.juz ?? '',
                      study: widget.profile.school_name ?? '',
                      work: widget.profile.company_name ?? '',
                    ),
                    const SizedBox(height: 40),
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
