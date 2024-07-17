import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/show_gifts/presentation/pages/show_gifts.dart';
import 'package:tanysu/l10n/translate.dart';

class SendGiftButton extends StatelessWidget {
  const SendGiftButton(
      {super.key, required this.userName, required this.profileId});
  final String userName;
  final int profileId;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/gift_white.svg',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 8),
            Center(
              child: Text(
                translation(context).send_a_gift,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.justify,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      onPressed: () {
        showGifts(
          context,
          userName,
          profileId,
        );
      },
    );
  }
}
