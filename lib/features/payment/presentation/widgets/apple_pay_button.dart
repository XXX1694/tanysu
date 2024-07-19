import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ApplePayButton extends StatelessWidget {
  const ApplePayButton({
    super.key,
    required this.price,
  });
  final int price;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.black54,
          //   width: 1,
          // ),
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
        ),
        height: 54,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 16),
            SvgPicture.asset(
              'assets/icons/apple.svg',
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Pay',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
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
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}
