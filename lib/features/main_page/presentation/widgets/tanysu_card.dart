import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tanysu/common/constants/colors.dart';

import 'package:tanysu/features/main_page/presentation/widgets/city_block.dart';
import 'package:tanysu/features/main_page/presentation/widgets/name_block.dart';
import 'package:tanysu/features/main_page/presentation/widgets/ru_block.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';

class TanysuCard extends StatefulWidget {
  const TanysuCard({
    super.key,
    required this.user,
    required this.controller,
  });
  final ProfileModel user;
  final AppinioSwiperController controller;
  @override
  State<TanysuCard> createState() => _TanysuCardState();
}

class _TanysuCardState extends State<TanysuCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            widget.user.images!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: widget.user.images![0]['image_url'],
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: secondColor,
                      highlightColor: mainColor,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black,
                  ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.0, 0.4],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Spacer(),
                  CityBlock(city: widget.user.city_name ?? ''),
                  const SizedBox(height: 8),
                  NameBlock(
                    name: widget.user.first_name ?? '',
                    age: widget.user.age ?? 0,
                    verified: widget.user.is_verified ?? false,
                  ),
                  const SizedBox(height: 8),
                  widget.user.juz != null
                      ? RuBlock(ru: widget.user.juz ?? '')
                      : const SizedBox(),
                  const SizedBox(height: 95),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
