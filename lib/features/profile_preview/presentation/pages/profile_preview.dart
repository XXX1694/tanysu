import 'dart:io';
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
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_about.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/profile_info_bloc_basic.dart';
import 'package:tanysu/features/profile_preview/presentation/widgets/send_gift_button.dart';
import 'package:tanysu/l10n/translate.dart';

class ProfilePreviewPageBasic extends StatefulWidget {
  const ProfilePreviewPageBasic({
    super.key,
    required this.profileId,
  });
  final int profileId;

  @override
  State<ProfilePreviewPageBasic> createState() =>
      _ProfilePreviewPageBasicState();
}

class _ProfilePreviewPageBasicState extends State<ProfilePreviewPageBasic> {
  late ProfilePreviewBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProfilePreviewBloc>(context);
    bloc.add(GetUserData(userId: widget.profileId));
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
                        ? const CircularProgressIndicator(
                            color: mainColor,
                            strokeWidth: 3,
                          )
                        : const CupertinoActivityIndicator(
                            color: mainColor,
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
                style: GoogleFonts.montserratAlternates(
                  color: mainColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              foregroundColor: Colors.black,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 40,
              leading: Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/icons/back_button.svg',
                      height: 24,
                      width: 24,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
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
                    showBlockIOS(
                      context,
                      state.model.first_name ?? '',
                      state.model.id ?? 0,
                    );
                  },
                ),
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 310,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: e['image_url'],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '${state.model.first_name}, ${state.model.age}',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                color: mainColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
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
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            color: Colors.black26,
                            height: 1,
                          ),
                          const SizedBox(height: 16),
                          ProfileInfoBlockBasic(
                            coins: 0,
                            followers: state.model.followers_count ?? 0,
                            profileId: state.model.id ?? 0,
                            isLiked: state.model.is_liked,
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: Colors.black26,
                            height: 1,
                          ),
                          const SizedBox(height: 16),
                          SendGiftButton(
                            userName: state.model.first_name ?? '',
                            profileId: state.model.id ?? 0,
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: Colors.black26,
                            height: 1,
                          ),
                          const SizedBox(height: 16),
                          ProfileAboutBlock(
                            about: state.model.about_me ?? '',
                            city: state.model.city_name ?? '',
                            job: state.model.profession ?? '',
                            ru: state.model.juz ?? '',
                            study: state.model.school_name ?? '',
                            work: state.model.company_name ?? '',
                          ),
                          const SizedBox(height: 4),
                          const Divider(
                            color: Colors.black26,
                            height: 1,
                          ),
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
