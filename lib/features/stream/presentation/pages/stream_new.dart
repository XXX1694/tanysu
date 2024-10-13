import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'dart:async';

class StreamingPage extends StatefulWidget {
  const StreamingPage({
    super.key,
    required this.isHost,
    required this.name,
    required this.profileId,
    required this.liveID,
  });
  final String liveID;
  final String name;
  final int profileId;
  final bool isHost;
  @override
  _StreamingPageState createState() => _StreamingPageState();
}

class _StreamingPageState extends State<StreamingPage> {
  final String serverDomain = 'streaming.tanysu.net';
  String streamId = 'example_stream_id'; // Replace with actual streamId
  String role = 'viewer'; // Replace with 'streamer' or 'viewer'

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  WebSocketChannel? _webSocketChannel;
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  Timer? _reconnectTimer;

  @override
  void initState() {
    super.initState();
    _initializeRenderers();
    _connectToWebSocket();
    role = widget.isHost ? 'streamer' : 'viewer';
    streamId = widget.liveID;
  }

  Future<void> _initializeRenderers() async {
    await _remoteRenderer.initialize();
    await _localRenderer.initialize();
  }

  void _connectToWebSocket() {
    _webSocketChannel = WebSocketChannel.connect(
      Uri.parse('wss://$serverDomain/ws/$streamId/$role?user_id=1'),
    );

    _webSocketChannel!.stream.listen(
      (event) async {
        final data = jsonDecode(event);
        print('WebSocket received: $data');

        switch (data['type']) {
          case 'offer':
            if (role == 'viewer') {
              await _handleOffer(data['offer']);
            }
            break;
          case 'answer':
            if (role == 'streamer') {
              await _handleAnswer(data['answer']);
            }
            break;
          case 'ice-candidate':
            await _handleIceCandidate(data['candidate']);
            break;
          default:
            print('Unknown message type: ${data['type']}');
        }
      },
      onError: (error) {
        print('WebSocket error: $error');
        _attemptReconnect();
      },
      onDone: () {
        print('WebSocket connection closed');
        _attemptReconnect();
      },
    );

    _createPeerConnection();
  }

  void _attemptReconnect() {
    if (_reconnectTimer == null || !_reconnectTimer!.isActive) {
      _reconnectTimer = Timer(Duration(seconds: 5), () {
        print('Attempting to reconnect to WebSocket...');
        _connectToWebSocket();
      });
    }
  }

  Future<void> _createPeerConnection() async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {
          'urls': 'turn:$serverDomain:3478',
          'username': 'testuser',
          'credential': 'Pa\$\$w0rd123!'
        },
      ]
    };

    try {
      _peerConnection = await createPeerConnection(configuration);
    } catch (e) {
      print('Failed to create peer connection: $e');
      return;
    }

    if (role == 'streamer') {
      await _setupLocalStream();
    } else if (role == 'viewer') {
      await _setupRemoteStream();
    }

    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      if (_webSocketChannel != null && _webSocketChannel!.closeCode == null) {
        print('Sending ICE candidate: ${candidate.toMap()}');
        _webSocketChannel!.sink.add(jsonEncode(
            {'type': 'ice-candidate', 'candidate': candidate.toMap()}));
      } else {
        print('WebSocket is closed. Cannot send ICE candidate.');
      }
    };
  }

  Future<void> _setupLocalStream() async {
    try {
      _localStream = await navigator.mediaDevices
          .getUserMedia({'video': true, 'audio': true});
    } catch (e) {
      print('Error getting user media: $e');
      return;
    }
    for (var track in _localStream!.getTracks()) {
      _peerConnection!.addTrack(track, _localStream!);
    }
    _localRenderer.srcObject = _localStream;
  }

  Future<void> _setupRemoteStream() async {
    _remoteStream = await createLocalMediaStream('remoteStream');
    _remoteRenderer.srcObject = _remoteStream;

    _peerConnection!.onTrack = (RTCTrackEvent event) {
      if (event.track.kind == 'video' || event.track.kind == 'audio') {
        _remoteStream!.addTrack(event.track);
      }
    };
  }

  Future<void> _handleOffer(String offer) async {
    await _peerConnection!
        .setRemoteDescription(RTCSessionDescription(offer, 'offer'));
    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);
    _webSocketChannel!.sink
        .add(jsonEncode({'type': 'answer', 'answer': answer.toMap()}));
  }

  Future<void> _handleAnswer(String answer) async {
    await _peerConnection!
        .setRemoteDescription(RTCSessionDescription(answer, 'answer'));
  }

  Future<void> _handleIceCandidate(Map<String, dynamic> candidate) async {
    await _peerConnection!.addCandidate(RTCIceCandidate(candidate['candidate'],
        candidate['sdpMid'], candidate['sdpMLineIndex']));
  }

  @override
  void dispose() {
    _reconnectTimer?.cancel();
    _webSocketChannel?.sink.close();
    _peerConnection?.close();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tanysu Streaming'),
      ),
      body: Column(
        children: [
          if (role == 'streamer')
            Expanded(
              child: SizedBox(
                  width: 300, height: 300, child: RTCVideoView(_localRenderer)),
            )
          else
            Expanded(
              child: RTCVideoView(_remoteRenderer),
            ),
          SizedBox(height: 20),
          Text(role == 'streamer' ? 'Streaming...' : 'Viewing...'),
        ],
      ),
    );
  }
}
