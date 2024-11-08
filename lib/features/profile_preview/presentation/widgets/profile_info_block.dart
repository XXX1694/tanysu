import 'package:appinio_swiper/appinio_swiper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/features/main_page/presentation/bloc/main_page_bloc.dart';
import 'package:tanysu/l10n/translate.dart';

class ProfileInfoBlock extends StatefulWidget {
  const ProfileInfoBlock({
    super.key,
    required this.coins,
    required this.followers,
    required this.controller,
    required this.isLiked,
    required this.profileId,
  });
  final int followers;
  final int coins;
  final AppinioSwiperController controller;
  final bool isLiked;
  final int profileId;

  @override
  State<ProfileInfoBlock> createState() => _ProfileInfoBlockState();
}

class _ProfileInfoBlockState extends State<ProfileInfoBlock> {
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              translation(context).followers,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black54,
                  ),
            )
          ],
        ),
        const SizedBox(width: 70),
        Column(
          children: [
            Text(
              '${widget.coins}K',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              translation(context).coins,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black54,
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
          ),
          onPressed: () async {
            !liked
                ? bloc.add(Like(profileId: widget.profileId))
                : bloc.add(UnLike(profileId: widget.profileId));
            setState(() {
              liked = !liked;
            });
            Navigator.pop(context);
            await Future.delayed(const Duration(milliseconds: 200));
            widget.controller.swipeRight();
          },
        ),
      ],
    );
  }
}

class ProfileInfoBlockForSearch extends StatefulWidget {
  const ProfileInfoBlockForSearch({
    super.key,
    required this.coins,
    required this.followers,
    required this.isLiked,
    required this.profileId,
  });
  final int followers;
  final int coins;
  final bool isLiked;
  final int profileId;

  @override
  State<ProfileInfoBlockForSearch> createState() =>
      _ProfileInfoBlockForSearchState();
}

class _ProfileInfoBlockForSearchState extends State<ProfileInfoBlockForSearch> {
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              translation(context).followers,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black54,
                  ),
            )
          ],
        ),
        const SizedBox(width: 70),
        Column(
          children: [
            Text(
              '${widget.coins}K',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              translation(context).coins,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black54,
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
            height: 32,
            width: 32,
          ),
          onPressed: () async {
            !liked
                ? bloc.add(Like(profileId: widget.profileId))
                : bloc.add(UnLike(profileId: widget.profileId));
            setState(() {
              liked = !liked;
            });
          },
        ),
      ],
    );
  }
}
