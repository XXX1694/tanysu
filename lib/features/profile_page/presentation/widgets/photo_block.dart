import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/widgets/placeholers.dart';
import 'package:tanysu/features/edit_profile/presentation/pages/edit_profile_page.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';
import 'package:tanysu/l10n/translate.dart';

class PhotoBlock extends StatelessWidget {
  const PhotoBlock({
    super.key,
    required this.profile,
  });
  final ProfileModel profile;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 198,
      width: 198,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: CachedNetworkImage(
                  imageUrl: profile.images!.isNotEmpty
                      ? profile.images![0]['image_url']
                      : '',
                  placeholder: (context, url) => const ShrimerPlaceholder(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  errorWidget: (context, url, error) => const ErrorPlaceholder(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CircularPercentIndicator(
              radius: 85,
              lineWidth: 6,
              percent: (profile.completeness ?? 0) / 100,
              progressColor: mainColor,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );
              },
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(5, 5),
                      blurRadius: 15,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/edit.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 30,
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${profile.completeness}% ${translation(context).complete}',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
