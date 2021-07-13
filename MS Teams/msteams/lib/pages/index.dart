import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:msteams/Screens/drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';

class IndexPage extends StatefulWidget {
  final String currentUserId;
  IndexPage({Key? key, required this.currentUserId}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      IndexState(currentUserId: currentUserId);
}

class IndexState extends State<IndexPage> {
  final String currentUserId;
  IndexState({Key? key, required this.currentUserId});

  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole? _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color.fromRGBO(99, 100, 167, 1)),
        title: Text(
          'Video Calls',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color.fromRGBO(99, 100, 167, 1)),
        ),
      ),
      drawer: NavigationDrawerWidget(
        currentUserId: currentUserId,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.035,
                ),
                Container(
                  child: Image.asset(
                    'images/5.jpeg',
                    height: height * 0.4,
                    width: height * 0.4,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: _channelController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.video_call_outlined),
                        fillColor: Color.fromRGBO(99, 100, 167, 1),
                        errorText:
                            _validateError ? 'Channel name is mandatory' : null,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Channel name',
                      ),
                    ))
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Join Video Call'),
                        leading: Radio(
                          value: ClientRole.Broadcaster,
                          groupValue: _role,
                          onChanged: (ClientRole? value) {
                            setState(() {
                              _role = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('Join Live Stream'),
                        leading: Radio(
                          value: ClientRole.Audience,
                          groupValue: _role,
                          onChanged: (ClientRole? value) {
                            setState(() {
                              _role = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onJoin,
                          child: Text('Join'),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(99, 100, 167, 1)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
