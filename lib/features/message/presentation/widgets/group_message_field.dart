import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class GroupMessageField extends StatelessWidget {
  const GroupMessageField({
    super.key,
    required this.controller,
    required this.sendMessageFunction,
  });
  final TextEditingController controller;
  final Function sendMessageFunction;
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
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
