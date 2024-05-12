import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tanysu/l10n/translate.dart';

class LiveFrontSideCreator extends StatelessWidget {
  const LiveFrontSideCreator({
    super.key,
    required this.endStream,
  });
  final Function endStream;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 16),
              SvgPicture.asset('assets/icons/stream/eye.svg'),
              const SizedBox(width: 4),
              Text(
                '0',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
              const Spacer(),
              SvgPicture.asset('assets/icons/stream/connection.svg'),
              const SizedBox(width: 12),
              Text(
                'LIVE',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  endStream();
                },
                child: SvgPicture.asset('assets/icons/stream/cancel.svg'),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/icons/stream/mask.svg',
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text(
                              translation(context).temporarily_not_working),
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
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text(
                              translation(context).temporarily_not_working),
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
                          title: Text(
                              translation(context).temporarily_not_working),
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
                    child: SvgPicture.asset(
                      'assets/icons/stream/settings.svg',
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
    );
  }
}
