import 'dart:async';

import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CallPage extends StatefulWidget {
  final String channelName;

  const CallPage({Key key, this.channelName}) : super(key: key);

  @override
  _CallPageState createState() {
    return new _CallPageState();
  }
}

class _CallPageState extends State<CallPage> {
  bool _muted = false;
  List _sessions = [];
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () => _onToggleMute(),
            child: new Icon(
              _muted ? Icons.mic : Icons.mic_off,
              color: _muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: _muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: new Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () => _onSwitchCamera(),
            child: new Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  void _onToggleMute() {
    setState(() {
      _muted = !_muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(_muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  List<Widget> _getRenderViews() {
    return _sessions.map<Widget>((session) => session.view).toList();
  }

  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  Widget _expandedVideoRow(List<Widget> views) {
    List<Widget> wrappedViews =
        views.map((Widget view) => _videoView(view)).toList();
    return Expanded(
        child: Row(
      children: wrappedViews,
    ));
  }

  List<Widget> _getVideoWidget() {
    List<Widget> views = _getRenderViews();
    List<Widget> res = [
      views.length >= 2 ?  Positioned(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromRGBO(22, 22, 22, 0.2),
          child: views[1],
        ),
      ) : SizedBox(),

      Positioned(
        child: Container(
          width:  80,
          height: 135,
          alignment: Alignment.centerRight,
          child: views.length >= 1 ? views[0] : SizedBox(),
        ),
        right: 0,
        top: 0,
      ),
      // Container(
      //   width: 80,
      //   height: 150,
      //   alignment: Alignment.centerRight,
      //   child:
      // )
    ];
    return res;
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    AgoraRtcEngine.create("5d84ebbdd256435198e82d6162dab042");
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.onError = (error) {};

    AgoraRtcEngine.onJoinChannelSuccess =
        (String channel, int uid, int elapsed) {};

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        _addRenderView(uid, (viewId) {
          AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Fit, uid);
        });
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        _removeRenderView(uid);
        Navigator.pop(context);
        EasyLoading.showInfo("对方已挂断");
        Timer(Duration(seconds: 3000), () {
          EasyLoading.dismiss();
        });
      });
    };
    _addRenderView(0, (viewId) {
      AgoraRtcEngine.setupLocalVideo(viewId, VideoRenderMode.Fit);
      AgoraRtcEngine.startPreview();
      AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);
    });
  }

  VideoSession _getVideoSession(int uid) {
    return _sessions.firstWhere((session) {
      return session.uid == uid;
    });
  }

  void _addRenderView(int uid, Function(int viewId) finished) {
    Widget view = AgoraRtcEngine.createNativeView((viewId) {
      setState(() {
        _getVideoSession(uid).viewId = viewId;
        if (finished != null) {
          finished(viewId);
        }
      });
    });
    VideoSession session = VideoSession(uid, view);
    _sessions.add(session);
  }

  void _removeRenderView(int uid) {
    VideoSession session = _getVideoSession(uid);
    if (session != null) {
      _sessions.remove(session);
    }
    AgoraRtcEngine.removeNativeView(session.viewId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: _getVideoWidget()..add(_toolbar()),
          // children: <Widget>[_viewRows(), _toolbar()],
        ),
      ),
    );
  }
}

class VideoSession {
  int uid;
  Widget view;
  int viewId;

  VideoSession(int uid, Widget view) {
    this.uid = uid;
    this.view = view;
  }
}
