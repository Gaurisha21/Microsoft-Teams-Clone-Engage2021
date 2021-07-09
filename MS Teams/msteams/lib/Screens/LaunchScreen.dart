import 'dart:async';
import 'HomePageScreen.dart';
// import 'SignUpScreen.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  var height, width;
  @override
  void initState() {
    var d = Duration(seconds: 3);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePageScreen(
              currentUserId: '',
            );
          },
        ),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(children: [
            Column(
              children: [
                Container(
                  child: Text(
                    'Microsoft Teams',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 21.5,
                        color: Colors.deepPurple[700]),
                  ),
                  padding: EdgeInsets.fromLTRB(10, height * 0.05, 10, 0),
                ),
                Container(
                  child: Image.asset(
                    'images/1.jpeg',
                    height: height * 0.35,
                    width: height * 0.35,
                  ),
                  padding: EdgeInsets.fromLTRB(10, height * 0.15, 10, 0),
                ),
                Container(
                  child: Text(
                      'Welcome to Microsoft \nTeams! A happier place for \nteams to work togather.',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                          color: Colors.black45),
                      textAlign: TextAlign.center),
                  padding: EdgeInsets.fromLTRB(
                      10, height * 0.13, 10, height * 0.045),
                ),
                Center(
                    child: CircularProgressIndicator(
                  strokeWidth: height * 0.0025,
                  color: Colors.deepPurple[700],
                )),
              ],
            )
          ]),
        ));
  }
}
