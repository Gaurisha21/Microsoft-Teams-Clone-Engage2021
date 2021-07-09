import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';

var height, width;

const APP_ID = "a61fadf6956d4968adaad0d7f6eafe52";
const Token =
    "0064289868d918343418fa04193fa0e0ac9IADCl37b+MG/1Jcq0Y5dORDbLE/a7zvTzg+0NzW1aYf5ak0sVPcAAAAAEABsKo0toWfpYAEAAQChZ+lg";

class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String? channelName = "chatCalling";

  /// non-modifiable client role of the page
  final ClientRole? role = ClientRole.Broadcaster;

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool disCam = true;
  late RtcEngine _engine;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    // ignore: deprecated_member_use
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(1920, 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(Token, widget.channelName!, null, 0);
    // ignore: unnecessary_null_comparison
    await _engine.renewToken(Token);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role!);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(
        child: Container(
      child: view,
    ));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return new Container(
            width: width,
            height: height,
            child: new Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      _expandedVideoRow([views[1]]),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(15, 115, 15, 15),
                        width: width * 0.35,
                        height: height * 0.23,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _expandedVideoRow([views[0]]),
                          ],
                        )))
              ],
            ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: RawMaterialButton(
              onPressed: _onToggleMute,
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
                color: muted ? Color.fromRGBO(99, 100, 167, 1) : Colors.white,
                size: 25.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: muted ? Colors.white : Color.fromRGBO(99, 100, 167, 1),
              padding: const EdgeInsets.all(8.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: RawMaterialButton(
              onPressed: _onSwitchCamera,
              child: Icon(
                Icons.switch_camera_outlined,
                color: Colors.white,
                size: 25.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Color.fromRGBO(99, 100, 167, 1),
              padding: const EdgeInsets.all(8.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: RawMaterialButton(
              onPressed: _onDisableCam,
              child: Icon(
                disCam ? Icons.videocam_rounded : Icons.videocam_off_rounded,
                color: disCam ? Colors.white : Color.fromRGBO(99, 100, 167, 1),
                size: 25.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor:
                  disCam ? Color.fromRGBO(99, 100, 167, 1) : Colors.white,
              padding: const EdgeInsets.all(8.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: RawMaterialButton(
              onPressed: () => _onCallEnd(context),
              child: Icon(
                Icons.call_end,
                color: Colors.white,
                size: 25.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
            ),
          ),
        ],
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onDisableCam() {
    setState(() {
      disCam = !disCam;
    });
    _engine.enableLocalVideo(disCam);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      backgroundColor: Colors.grey[900]!.withOpacity(0.5),
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Microsoft Teams',
        style: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 22, color: Colors.white),
      ),
    );
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _visible ? appbar : null,
      body: Container(
        child: GestureDetector(
          onTap: () {
            setState(() => {_visible = !_visible});
          },
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: Stack(
              children: <Widget>[
                Container(child: _viewRows()),
                Container(child: _visible ? _toolbar() : null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
