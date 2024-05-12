import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/l10n/translate.dart';

class StreamTopBar extends StatelessWidget {
  const StreamTopBar({
    super.key,
    required this.startStream,
    required this.endStream,
  });
  final Function startStream;
  final Function endStream;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    endStream();
                    // Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/stream/back.svg',
                  ),
                ),
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/icons/stream/mask.svg',
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title:
                            Text(translation(context).temporarily_not_working),
                        content: Text(translation(context)
                            .temporarily_not_working_second),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text(translation(context).temporarily_not_working),
                    content: Text(
                        translation(context).temporarily_not_working_second),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      )
                    ],
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/icons/stream/share.svg',
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text(translation(context).temporarily_not_working),
                    content: Text(
                        translation(context).temporarily_not_working_second),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      )
                    ],
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/icons/stream/settings.svg',
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 17,
                ),
                color: mainColor,
                borderRadius: BorderRadius.circular(100),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/stream/camera.svg'),
                      const SizedBox(width: 8),
                      Text(
                        translation(context).go_live,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  startStream();
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
