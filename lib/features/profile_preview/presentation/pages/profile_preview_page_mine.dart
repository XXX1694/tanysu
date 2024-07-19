import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        title: Text(
          'PANDEYA',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
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
                        width: 310,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: e['image_url'] ?? '',
                            placeholder: (context, url) =>
                                const ShrimerPlaceholder(
                              height: 210,
                              width: 165,
                            ),
                            errorWidget: (context, url, error) =>
                                const ErrorPlaceholder(
                              height: 210,
                              width: 165,
                            ),
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
                      followeings: widget.profile.followeings ?? 0,
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
