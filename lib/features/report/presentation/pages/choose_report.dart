import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          translation(context).report,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
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
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      translation(context).fake_profile,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
                const Divider(),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      translation(context).inapropriate_content,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
                const Divider(),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      translation(context).adv,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
                const Divider(),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      translation(context).disc,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
                const Divider(),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      translation(context).y_user,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
                const Divider(),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      translation(context).not_interested,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
                const Divider(),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      translation(context).other_p,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
