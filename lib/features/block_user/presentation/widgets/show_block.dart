import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/block_user/presentation/bloc/block_user_bloc.dart';
import 'package:tanysu/features/report/presentation/pages/choose_report.dart';
import 'package:tanysu/l10n/translate.dart';

Future showBlockIOS(
  BuildContext context,
  String userName,
  int profileId,
) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => CuprtinoActionSheetBuilder(
      profileId: profileId,
      userName: userName,
    ),
  );
}

class CuprtinoActionSheetBuilder extends StatefulWidget {
  const CuprtinoActionSheetBuilder({
    super.key,
    required this.userName,
    required this.profileId,
  });
  final String userName;
  final int profileId;
  @override
  State<CuprtinoActionSheetBuilder> createState() =>
      _CuprtinoActionSheetBuilderState();
}

class _CuprtinoActionSheetBuilderState
    extends State<CuprtinoActionSheetBuilder> {
  late BlockUserBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<BlockUserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlockUserBloc, BlockUserState>(
      builder: (context, state) => CupertinoActionSheet(
        title: Text(
          '${translation(context).block} ${widget.userName}',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        message: Text(translation(context).block_sub),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              bloc.add(BlockUser(profileId: widget.profileId));
            },
            child: Text(translation(context).block),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChooseReportPage(
                    profileId: widget.profileId,
                  ),
                ),
              );
            },
            child: Text(translation(context).report),
          ),
        ],
      ),
      listener: (context, state) {
        if (state is UserBlocking) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Platform.isAndroid
                    ? CircularProgressIndicator(
                        color: secondColor,
                        strokeWidth: 3,
                      )
                    : CupertinoActivityIndicator(
                        color: secondColor,
                      ),
              );
            },
          );
        } else if (state is UserBlocked) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: 'Tanysu',
              body: translation(context).user_blocked,
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is UserUnBlocked) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: 'Tanysu',
              body: translation(context).user_blocked,
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: 'Tanysu',
              body: translation(context).user_block_error,
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
    );
  }
}

Future showBlock(BuildContext context, String userName, int profileId) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return BlockPart(
        profileId: profileId,
        userName: userName,
      );
    },
  );
}

class BlockPart extends StatefulWidget {
  const BlockPart({
    super.key,
    required this.profileId,
    required this.userName,
  });
  final String userName;
  final int profileId;
  @override
  State<BlockPart> createState() => _BlockPartState();
}

class _BlockPartState extends State<BlockPart> {
  late BlockUserBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<BlockUserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlockUserBloc, BlockUserState>(
      builder: (context, state) => Container(
        height: 250,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(35, 35, 35, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${translation(context).block} ${widget.userName}',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translation(context).block_sub,
                    style: GoogleFonts.montserrat(
                      color: Colors.black45,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(20),
                    content: Text(
                      translation(context).do_you_really,
                      textAlign: TextAlign.center,
                    ),
                    contentTextStyle: TextStyle(
                      color: secondColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          bloc.add(BlockUser(profileId: widget.profileId));
                        },
                        child: Text(translation(context).yes),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(translation(context).no),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.black26),
            const SizedBox(height: 12),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${translation(context).report} ${widget.userName}',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translation(context).report_sub,
                    style: GoogleFonts.montserrat(
                      color: Colors.black45,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseReportPage(
                      profileId: widget.profileId,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.black26),
            const SizedBox(height: 12),
            // CupertinoButton(
            //   padding: const EdgeInsets.all(0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Share profile',
            //         style: GoogleFonts.montserrat(
            //           color: Colors.black,
            //           fontSize: 18,
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //       const SizedBox(height: 8),
            //       Text(
            //         'Share with most interesting persons',
            //         style: GoogleFonts.montserrat(
            //           color: Colors.black45,
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ),
            //     ],
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
      listener: (context, state) {
        if (state is UserBlocking) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Platform.isAndroid
                    ? CircularProgressIndicator(
                        color: secondColor,
                        strokeWidth: 3,
                      )
                    : CupertinoActivityIndicator(
                        color: secondColor,
                      ),
              );
            },
          );
        } else if (state is UserBlocked) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: 'Tanysu',
              body: translation(context).user_blocked,
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is UserUnBlocked) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: 'Tanysu',
              body: translation(context).user_blocked,
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: 'Tanysu',
              body: translation(context).user_block_error,
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
    );
  }
}
