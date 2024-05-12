import 'package:flutter/material.dart';
import 'package:tanysu/features/live/presentation/widgets/stream_top_bar.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ILSSpeakerPrepareView extends StatefulWidget {
  final int profileId;
  const ILSSpeakerPrepareView({
    super.key,
    required this.profileId,
  });

  @override
  State<ILSSpeakerPrepareView> createState() => _ILSSpeakerPrepareView();
}

class _ILSSpeakerPrepareView extends State<ILSSpeakerPrepareView> {
  var micEnabled = true;
  var camEnabled = true;
  String hlsState = "HLS_STOPPED";
  late WebSocketChannel channel;
  @override
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        StreamTopBar(
          startStream: () {},
          endStream: () {},
        )
      ],
    );
  }
}
