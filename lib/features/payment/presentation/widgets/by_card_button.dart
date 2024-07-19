import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/l10n/translate.dart';

class ByCardButton extends StatelessWidget {
  const ByCardButton({
    super.key,
    required this.price,
    required this.onPressed,
  });
  final int price;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black54,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        height: 54,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              translation(context).card,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/coin.svg',
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '$price',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
