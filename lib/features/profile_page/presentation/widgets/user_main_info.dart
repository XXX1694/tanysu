import 'package:flutter/material.dart';
import 'package:tanysu/features/like_page/presentation/pages/like_page.dart';
import 'package:tanysu/l10n/translate.dart';

class UserMainInfo extends StatelessWidget {
  const UserMainInfo({
    super.key,
    required this.followeings,
    required this.followers,
    required this.likes,
    required this.newLikes,
  });
  final int followeings;
  final int followers;
  final int likes;
  final int newLikes;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/subscribers');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$followers',
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
              ),
            ],
          ),
        ),
        const SizedBox(width: 52),

        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/subscribers');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$followeings',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                translation(context).followings,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black54,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 52),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LikePage(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$likes',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  newLikes > 0
                      ? Text(
                          ' + $newLikes',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                        )
                      : const SizedBox(),
                ],
              ),
              Text(
                translation(context).profile_likes,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black54,
                    ),
              ),
            ],
          ),
        ),
        // CupertinoButton(
        //   padding: const EdgeInsets.all(0),
        //   child: Container(
        //     height: 39,
        //     width: 119,
        //     decoration: BoxDecoration(
        //       color: mainColor,
        //       borderRadius: BorderRadius.circular(100),
        //     ),
        //     child: Center(
        //       child: Text(
        //         translation(context).buy_a_coin,
        //         style: GoogleFonts.montserrat(
        //           color: Colors.white,
        //           fontSize: 14,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //     ),
        //   ),
        //   onPressed: () {
        //     showSnackBar(context, translation(context).payment_not_working);
        //   },
        // ),
      ],
    );
  }
}

class UserMainInfoMine extends StatelessWidget {
  const UserMainInfoMine({
    super.key,
    required this.followeings,
    required this.followers,
    required this.likes,
    required this.newLikes,
  });
  final int followeings;
  final int followers;
  final int likes;
  final int newLikes;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$followers',
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
            ),
          ],
        ),
        const SizedBox(width: 52),

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$followeings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              translation(context).followings,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black54,
                  ),
            ),
          ],
        ),
        const SizedBox(width: 52),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$likes',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                newLikes > 0
                    ? Text(
                        ' + $newLikes',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                      )
                    : const SizedBox(),
              ],
            ),
            Text(
              translation(context).profile_likes,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black54,
                  ),
            ),
          ],
        ),
        // CupertinoButton(
        //   padding: const EdgeInsets.all(0),
        //   child: Container(
        //     height: 39,
        //     width: 119,
        //     decoration: BoxDecoration(
        //       color: mainColor,
        //       borderRadius: BorderRadius.circular(100),
        //     ),
        //     child: Center(
        //       child: Text(
        //         translation(context).buy_a_coin,
        //         style: GoogleFonts.montserrat(
        //           color: Colors.white,
        //           fontSize: 14,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //     ),
        //   ),
        //   onPressed: () {
        //     showSnackBar(context, translation(context).payment_not_working);
        //   },
        // ),
      ],
    );
  }
}
