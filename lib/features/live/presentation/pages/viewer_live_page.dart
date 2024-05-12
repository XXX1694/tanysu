import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/features/live/presentation/widgets/viewer_chat_block.dart';

class ILSViewerView extends StatefulWidget {
  final int profileId;
  const ILSViewerView({
    super.key,
    required this.profileId,
  });

  @override
  State<ILSViewerView> createState() => _ILSViewerViewState();
}

class _ILSViewerViewState extends State<ILSViewerView> {
  String hlsState = "HLS_STOPPED";
  String? downstreamUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.3],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0, 0.3],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      child: SvgPicture.asset('assets/icons/stream/back.svg'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    SvgPicture.asset('assets/icons/stream/eye.svg'),
                    const SizedBox(width: 4),
                    Text(
                      '0',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ViewerChatBlock(
                  profileId: widget.profileId,
                  roomId: '',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
