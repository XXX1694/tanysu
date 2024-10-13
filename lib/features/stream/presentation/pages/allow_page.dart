// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/features/main_screen.dart';
import 'package:tanysu/features/stream/presentation/pages/stream_new.dart';
import 'package:tanysu/l10n/translate.dart';

class AllowPage extends StatefulWidget {
  const AllowPage({
    super.key,
    required this.liveID,
    this.isHost = false,
    required this.name,
    required this.profileId,
  });
  final String liveID;
  final bool isHost;
  final String name;
  final int profileId;
  @override
  State<AllowPage> createState() => _AllowPageState();
}

class _AllowPageState extends State<AllowPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Tanysu',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                translation(context).allow_main_text,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 32),
              Text(
                translation(context).allow_list_1,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 20),
              Text(
                translation(context).allow_list_2,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 20),
              Text(
                translation(context).allow_list_3,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const Spacer(),
              MainButton(
                text: translation(context).next,
                onPressed: () async {
                  var statusCamera = await Permission.camera.status;
                  if (statusCamera.isGranted) {
                    var statusMicrophone = await Permission.microphone.status;
                    if (statusMicrophone.isGranted) {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StreamingPage(
                            liveID: widget.liveID,
                            name: widget.name,
                            profileId: widget.profileId,
                            isHost: widget.isHost,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (kDebugMode) {
                          print('Returned result from SecondPage: $result');
                        }
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                          (context) => false,
                        );
                      }
                    } else if (statusMicrophone.isPermanentlyDenied) {
                      // openAppSettings();
                    } else {
                      await Permission.microphone.request();
                    }
                  } else if (statusCamera.isPermanentlyDenied) {
                    // openAppSettings();
                  } else {
                    await Permission.camera.request();
                  }
                },
                status: 'active',
              ),
              const SizedBox(height: 12),
              Text(
                translation(context).allow_second_text,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black54,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
