import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tanysu/features/live/presentation/widgets/live_front_side_creator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ILSSpeakerView extends StatefulWidget {
  final int profileId;
  final Function endStream;
  const ILSSpeakerView({
    super.key,
    required this.profileId,
    required this.endStream,
  });

  @override
  State<ILSSpeakerView> createState() => _ILSSpeakerViewState();
}

class _ILSSpeakerViewState extends State<ILSSpeakerView> {
  var micEnabled = true;
  var camEnabled = true;
  late WebSocketChannel channel;
  @override
  void initState() {
    super.initState();
    // channel = WebSocketChannel.connect(
    // Uri.parse(
    //     'wss://tanysu.net/ws/stream/${widget.profileId}/${widget.room.id}/'),
    // );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
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
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                stops: const [0, 0.3],
              ),
            ),
          ),
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (kDebugMode) {
                  print(snapshot.data);
                }
                return const SizedBox();
              } else {
                return const SizedBox();
              }
            },
          ),
          LiveFrontSideCreator(
            endStream: () {
              Navigator.pop(context);
              widget.endStream();
            },
          ),
        ],
      ),
    );
  }
}
