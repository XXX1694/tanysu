import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/profile_preview/presentation/bloc/profile_preview_bloc.dart';
import 'package:tanysu/l10n/translate.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({
    super.key,
    required this.folloewed,
    required this.profileId,
  });
  final bool folloewed;
  final int profileId;
  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool follow = false;
  late ProfilePreviewBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProfilePreviewBloc>(context);
    follow = widget.folloewed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        setState(() {
          follow = !follow;
          if (follow) {
            bloc.add(FollowUnfollow(profileId: widget.profileId));
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          gradient: !follow
              ? LinearGradient(
                  colors: [
                    mainColor,
                    secondColor,
                  ],
                )
              : null,
          color: follow ? mainColor20 : null,
          borderRadius: BorderRadius.circular(80),
        ),
        child: Center(
          child: Text(
            follow
                ? translation(context).unfollow
                : translation(context).follow,
            style: GoogleFonts.montserrat(
              color: follow ? mainColor : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
