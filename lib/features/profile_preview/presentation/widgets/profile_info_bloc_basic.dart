import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/main_page/presentation/bloc/main_page_bloc.dart';
import 'package:tanysu/l10n/translate.dart';

class ProfileInfoBlockBasic extends StatefulWidget {
  const ProfileInfoBlockBasic({
    super.key,
    required this.coins,
    required this.followers,
    required this.profileId,
    required this.isLiked,
  });
  final int followers;
  final int coins;
  final int profileId;
  final bool isLiked;

  @override
  State<ProfileInfoBlockBasic> createState() => _ProfileInfoBlockBasicState();
}

class _ProfileInfoBlockBasicState extends State<ProfileInfoBlockBasic> {
  late bool liked;

  late MainPageBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<MainPageBloc>(context);
    liked = widget.isLiked;
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
            liked
                ? 'assets/icons/like_filled.svg'
                : 'assets/icons/like_outlined.svg',
            height: 36,
            width: 36,

            // ignore: deprecated_member_use
            color: liked ? Colors.red : Colors.black,
          ),
          onPressed: () async {
            !liked
                ? bloc.add(Like(profileId: widget.profileId))
                : bloc.add(UnLike(profileId: widget.profileId));
            setState(() {
              liked = !liked;
            });

            // Navigator.pop(context);
            // await Future.delayed(const Duration(milliseconds: 200));
            // controller.swipeRight();
          },
        ),
      ],
    );
  }
}
