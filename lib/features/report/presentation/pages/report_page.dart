import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/core/widgets/main_button_filled.dart';
import 'package:tanysu/features/report/presentation/bloc/report_bloc.dart';
import 'package:tanysu/features/report/presentation/widgets/report_field.dart';
import 'package:tanysu/features/report/presentation/widgets/report_main_text.dart';
import 'package:tanysu/features/report/presentation/widgets/report_second_text.dart';
import 'package:tanysu/l10n/translate.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({
    super.key,
    required this.profileId,
    required this.category,
  });
  final int profileId;
  final int category;
  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late TextEditingController _reportController;
  late ReportBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ReportBloc>(context);
    _reportController = TextEditingController();
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
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.black26,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const ReportMainText(),
              const SizedBox(height: 40),
              ReportField(controller: _reportController),
              const SizedBox(height: 12),
              const ReportSecondText(),
              const Spacer(),
              BlocConsumer<ReportBloc, ReportState>(
                listener: (context, state) {
                  if (state is UserReported) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is UserReporting) {
                    return const MainButtonFilledLoading();
                  } else {
                    return MainButton(
                      text: translation(context).report,
                      onPressed: () {
                        bloc.add(
                          ReportUser(
                            category: widget.category,
                            description: _reportController.text,
                            recipient: widget.profileId,
                          ),
                        );
                      },
                      status: 'active',
                    );
                  }
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }
}
