import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/widgets/placeholers.dart';
import 'package:tanysu/features/profile_page/presentation/widgets/user_main_info.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_about.dart';

class ProfilePreviewPageMine extends StatefulWidget {
  const ProfilePreviewPageMine({super.key, required this.profile});
  final ProfileModel profile;
  @override
  State<ProfilePreviewPageMine> createState() => _ProfilePreviewPageMineState();
}

class _ProfilePreviewPageMineState extends State<ProfilePreviewPageMine> {
  final AppinioSwiperController controller = AppinioSwiperController();
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
        centerTitle: true,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
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
                        height: double.infinity,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: e['image_url'] ?? '',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.profile.first_name ?? ''}, ${widget.profile.age ?? ''}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    UserMainInfoMine(
                      followers: widget.profile.followers_count ?? 0,
                      likes: widget.profile.likes ?? 0,
                      followeings: widget.profile.following_count ?? 0,
                      newLikes: widget.profile.new_likes ?? 0,
                    ),
                    const SizedBox(height: 20),
                    // const Divider(color: Colors.black26),
                    // const SizedBox(height: 12),
                    // ProfileInfoBlockMine(
                    //   coins: 0,
                    //   followers: widget.profile.followers_count ?? 0,
                    //   controller: controller,
                    //   isLiked: widget.profile.is_liked,
                    // ),
                    // const SizedBox(height: 12),
                    // const Divider(color: Colors.black26),
                    // const SizedBox(height: 12),
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     FollowButton(),
                    //   ],
                    // ),
                    // const SizedBox(height: 12),
                    // SendGiftButton(userName: widget.profile.first_name ?? ''),
                    const Divider(
                      color: Colors.black12,
                      height: 1,
                    ),
                    const SizedBox(height: 20),
                    ProfileAboutBlock(
                      about: widget.profile.about_me ?? '',
                      city: widget.profile.city_name ?? '',
                      job: widget.profile.profession ?? '',
                      ru: widget.profile.juz ?? '',
                      study: widget.profile.school_name ?? '',
                      work: widget.profile.company_name ?? '',
                    ),
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
