import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;
  final String name;
  final int profileId;

  const LivePage({
    super.key,
    required this.liveID,
    this.isHost = false,
    required this.name,
    required this.profileId,
  });

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  late WebSocketChannel channel;

  @override
  void initState() {
    if (kDebugMode) {
      print('wss://tanysu.net/ws/stream/${widget.profileId}/${widget.liveID}/');
    }
    channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://tanysu.net/ws/stream/${widget.profileId}/${widget.liveID}/'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print(snapshot.data);
            }
            return SafeArea(
              child: ZegoUIKitPrebuiltLiveStreaming(
                appID:
                    249797448, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
                appSign:
                    'a8d3f6de3e464385099caf470a53373573263131eab9cf129c5b2509e3aa4911', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
                userID: widget.profileId.toString(),
                userName: widget.name,
                liveID: widget.liveID,
                config: widget.isHost
                    ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
                    : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
              ),
            );
          } else {
            return const Center(
              child: Text('Создание стрима...'),
            );
          }
        },
      ),
    );
  }
}
