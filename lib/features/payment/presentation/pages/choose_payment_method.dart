import 'package:flutter/material.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/features/payment/presentation/widgets/apple_pay_button.dart';
import 'package:tanysu/features/payment/presentation/widgets/by_card_button.dart';
import 'package:tanysu/features/payment/presentation/widgets/card_cvv_field.dart';
import 'package:tanysu/features/payment/presentation/widgets/card_date_field.dart';
import 'package:tanysu/features/payment/presentation/widgets/card_number_field.dart';
import 'package:tanysu/features/payment/presentation/widgets/cardholed_field.dart';

import 'package:tanysu/l10n/translate.dart';

Future showPaymentMethod(BuildContext context, int coinNumber, int price) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ChoosePaymentMethod(
          price: price,
          coinNumber: coinNumber,
        ),
      );
    },
  );
}

class ChoosePaymentMethod extends StatefulWidget {
  const ChoosePaymentMethod({
    super.key,
    required this.coinNumber,
    required this.price,
  });
  final int coinNumber;
  final int price;
  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  late TextEditingController cardNumberController;
  late TextEditingController cardholerController;
  late TextEditingController dateController;
  late TextEditingController cvvController;
  @override
  void initState() {
    cardNumberController = TextEditingController();
    cardholerController = TextEditingController();
    dateController = TextEditingController();
    cvvController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardholerController.dispose();
    dateController.dispose();
    cvvController.dispose();

    super.dispose();
  }

  bool inCard = false;
  @override
  Widget build(BuildContext context) {
    if (inCard) {
      return SizedBox(
        height: 440,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translation(context).cardCredentials,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 40),
              CardNumberField(
                controller: cardNumberController,
              ),
              const SizedBox(height: 20),
              CardholedField(
                controller: cardholerController,
              ),
              const SizedBox(height: 20),
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: CardDateField(
                        controller: dateController,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: CardCvvField(
                        controller: cvvController,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              MainButton(
                  text: '${translation(context).pay_money} ${widget.price}₸',
                  onPressed: () {},
                  status: 'active'),
              const Spacer(),
              // MainButton(
              //   text: '${translation(context).pay} ₸ $price',
              //   onPressed: () {},
              //   status: 'active',
              // ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 290,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translation(context).get_coins,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 40),
              ByCardButton(
                price: widget.price,
                onPressed: () {
                  setState(() {
                    inCard = true;
                  });
                },
              ),
              const SizedBox(height: 12),
              ApplePayButton(
                price: widget.price,
              ),
              const SizedBox(height: 8),
              // MainButton(
              //   text: '${translation(context).pay} ₸ $price',
              //   onPressed: () {},
              //   status: 'active',
              // ),
            ],
          ),
        ),
      );
    }
  }
}
