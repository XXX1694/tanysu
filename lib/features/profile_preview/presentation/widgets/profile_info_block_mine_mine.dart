import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/main_page/presentation/bloc/main_page_bloc.dart';
import 'package:tanysu/l10n/translate.dart';

class ProfileInfoBlockMine extends StatefulWidget {
  const ProfileInfoBlockMine({
    super.key,
    required this.coins,
    required this.followers,
    required this.controller,
    required this.isLiked,
  });
  final int followers;
  final int coins;
  final AppinioSwiperController controller;
  final bool isLiked;

  @override
  State<ProfileInfoBlockMine> createState() => _ProfileInfoBlockMineState();
}

class _ProfileInfoBlockMineState extends State<ProfileInfoBlockMine> {
  late MainPageBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<MainPageBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              '${widget.followers}',
              style: GoogleFonts.montserrat(
                color: mainColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Text(
              translation(context).followers,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            )
          ],
        ),
        const SizedBox(width: 70),
        Column(
          children: [
            Text(
              '${widget.coins}K',
              style: GoogleFonts.montserrat(
                color: mainColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Text(
              translation(context).coins,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            )
          ],
        ),
        const SizedBox(width: 70),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: SvgPicture.asset(
            'assets/icons/like_outlined.svg',
            height: 36,
            width: 36,
            // ignore: deprecated_member_use
            color: widget.isLiked ? Colors.red : Colors.transparent,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
