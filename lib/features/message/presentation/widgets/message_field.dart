import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorHeight: 18,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              // textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              maxLines: 1,
              controller: messageController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                fillColor: Colors.white,
                hintText: translation(context).message,
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: mainColor20,
                    width: 1,
                  ),
                ),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: mainColor20,
                    width: 1,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: mainColor20,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: mainColor50,
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
                  color: mainColor20,
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
                  color: mainColor20,
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
      ),
    );
  }
}
