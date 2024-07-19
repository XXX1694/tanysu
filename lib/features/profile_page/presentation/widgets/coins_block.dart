import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/payment/presentation/pages/choose_payment_method.dart';
import 'package:tanysu/l10n/translate.dart';

class CoinsBlock extends StatelessWidget {
  const CoinsBlock({
    super.key,
    required this.coins,
    required this.userName,
  });
  final int coins;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$coins ',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                TextSpan(
                  text: translation(context).coins,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black54,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/coin.svg',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '500',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      '1000KZT',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: accentColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            onPressed: () {
              showPaymentMethod(
                context,
                500,
                1000,
              );
            },
          ),
          const SizedBox(height: 16),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/coin.svg',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '1000',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      '1800KZT',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: accentColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            onPressed: () {
              showPaymentMethod(
                context,
                1000,
                1800,
              );
            },
          ),
          const SizedBox(height: 16),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/coin.svg',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '2000',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      '3000KZT',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: accentColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            onPressed: () {
              showPaymentMethod(
                context,
                2000,
                3000,
              );
            },
          ),
        ],
      ),
    );
  }
}
