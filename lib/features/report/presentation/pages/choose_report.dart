import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/features/report/presentation/bloc/report_bloc.dart';
import 'package:tanysu/features/report/presentation/pages/report_page.dart';
import 'package:tanysu/l10n/translate.dart';

class ChooseReportPage extends StatefulWidget {
  const ChooseReportPage({
    super.key,
    required this.profileId,
  });
  final int profileId;

  @override
  State<ChooseReportPage> createState() => _ChooseReportPageState();
}

class _ChooseReportPageState extends State<ChooseReportPage> {
  late ReportBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ReportBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          translation(context).report,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.black12,
          ),
        ),
      ),
      body: BlocConsumer<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state is UserReported) {
            Navigator.pop(context);
            Navigator.pop(context);
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                title: 'Tanysu',
                body: translation(context).user_reported,
              ),
            );
          } else {
            Navigator.pop(context);
            Navigator.pop(context);
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                title: 'Tanysu',
                body: translation(context).user_report_error,
              ),
            );
          }
        },
        builder: (context, state) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 20),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/report_icons/fake_profile.svg',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        translation(context).fake_profile,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    bloc.add(
                      ReportUser(
                        category: 1,
                        description: '',
                        recipient: widget.profileId,
                      ),
                    );
                  },
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/report_icons/innapropriate_content.svg',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        translation(context).inapropriate_content,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    bloc.add(
                      ReportUser(
                        category: 2,
                        description: '',
                        recipient: widget.profileId,
                      ),
                    );
                  },
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/report_icons/fraud.svg',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        translation(context).adv,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    bloc.add(
                      ReportUser(
                        category: 3,
                        description: '',
                        recipient: widget.profileId,
                      ),
                    );
                  },
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/report_icons/discrimination.svg',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        translation(context).disc,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    bloc.add(
                      ReportUser(
                        category: 4,
                        description: '',
                        recipient: widget.profileId,
                      ),
                    );
                  },
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/report_icons/minor_user.svg',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        translation(context).y_user,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    bloc.add(
                      ReportUser(
                        category: 5,
                        description: '',
                        recipient: widget.profileId,
                      ),
                    );
                  },
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/report_icons/not_interested.svg',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        translation(context).not_interested,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    bloc.add(
                      ReportUser(
                        category: 3,
                        description: '',
                        recipient: widget.profileId,
                      ),
                    );
                  },
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/report_icons/other.svg',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        translation(context).other_p,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportPage(
                          profileId: widget.profileId,
                          category: 6,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
