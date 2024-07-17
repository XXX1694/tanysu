import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tanysu/features/message/presentation/widgets/show_gifts_chat.dart';

import 'package:tanysu/l10n/translate.dart';

import '../../../../core/constants/colors.dart';

class MessageField extends StatelessWidget {
  const MessageField({
    super.key,
    required this.sendMessageFunction,
    required this.sendGiftFunction,
    required this.messageController,
    required this.profileId,
  });
  final Function sendMessageFunction;
  final Function({required int giftId}) sendGiftFunction;
  final TextEditingController messageController;
  final int profileId;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            cursorHeight: 18,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.black,
                ),
            // textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            minLines: 1,
            maxLines: 4,
            controller: messageController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              fillColor: Colors.white,
              hintText: translation(context).message,
              hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.black54,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: accentColor20,
                  width: 1,
                ),
              ),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: accentColor20,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: accentColor20,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: mainColor,
                ),
              ),
            ),
            onSubmitted: (value) {
              sendMessageFunction();
            },
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          child: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: accentColor20,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/gift_black.svg',
              ),
            ),
          ),
          onTap: () {
            // print('send gift button presed');
            showChatGifts(context, profileId, sendGiftFunction);
          },
        ),
        const SizedBox(width: 4),
        GestureDetector(
          child: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: accentColor20,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/send_black.svg',
              ),
            ),
          ),
          onTap: () {
            sendMessageFunction();
          },
        ),
      ],
    );
  }
}
