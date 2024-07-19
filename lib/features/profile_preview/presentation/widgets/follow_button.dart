import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return GestureDetector(
      onTap: () {
        setState(() {
          follow = !follow;
          if (follow) {
            bloc.add(FollowUnfollow(profileId: widget.profileId));
          }
        });
      },
      child: Container(
        height: 32,
        width: 128,
        decoration: BoxDecoration(
            color: !follow ? Colors.transparent : mainColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: !follow ? Colors.black38 : Colors.transparent)),
        child: Center(
          child: Text(
            follow
                ? translation(context).unfollow
                : translation(context).follow,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: !follow ? Colors.black54 : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
