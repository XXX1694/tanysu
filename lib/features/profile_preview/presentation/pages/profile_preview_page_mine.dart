import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tanysu/common/constants/colors.dart';
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
                            e['image_url'] ?? '',
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
                    '${widget.profile.first_name ?? ''}, ${widget.profile.age ?? ''}',
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
