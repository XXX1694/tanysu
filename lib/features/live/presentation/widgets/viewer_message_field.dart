import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';

class ViewerMessageField extends StatelessWidget {
  const ViewerMessageField({
    super.key,
    required this.sendMessageFunction,
    required this.sendGiftFunction,
    required this.messageController,
  });
  final Function sendMessageFunction;
  final Function() sendGiftFunction;
  final TextEditingController messageController;
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
                color: Colors.white,
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
                // fillColor: Colors.white,
                hintText: translation(context).message,
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                // filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
              ),
              onSubmitted: (value) {
                sendMessageFunction();
              },
            ),
          ),
          // const SizedBox(width: 4),
          // GestureDetector(
          //   child: Container(
          //     height: 44,
          //     width: 44,
          //     decoration: BoxDecoration(
          //       // color: Colors.white,
          //       borderRadius: BorderRadius.circular(12),
          //       border: Border.all(
          //         width: 1,
          //         color: Colors.white,
          //       ),
          //     ),
          //     child: Center(
          //       child: SvgPicture.asset(
          //         'assets/icons/gift_black.svg',
          //       ),
          //     ),
          //   ),
          //   onTap: () {
          //     sendGiftFunction();
          //   },
          // ),
          const SizedBox(width: 4),
          GestureDetector(
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/stream/send_white.svg',
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
