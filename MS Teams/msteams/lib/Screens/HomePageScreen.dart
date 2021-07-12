import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SignUpScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'drawer.dart';

class HomePageScreen extends StatefulWidget {
  final String currentUserId;
  HomePageScreen({Key? key, required this.currentUserId}) : super(key: key);
  @override
  _HomePageScreenState createState() =>
      _HomePageScreenState(currentUserId: currentUserId);
}

class _HomePageScreenState extends State<HomePageScreen> {
  final String currentUserId;
  // ignore: unused_element
  _HomePageScreenState({Key? key, required this.currentUserId});

  var height, width;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isloggedin = false;

  Future getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser!;
        this.isloggedin = true;
      });
    }
  }

  Future checkAuthentification() async {
    await _auth.authStateChanges().listen((user) {
      if (user == null) {
        print('redirecting');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      }
    });
  }

  Future signOut(context) async {
    _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification().whenComplete(() {
      setState(() {});
    });
    this.getUser().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: NavigationDrawerWidget(
        currentUserId: currentUserId,
      ),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(99, 100, 167, 1)),
          elevation: 0.0,
          title: Text(
            'Dash Board',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color.fromRGBO(99, 100, 167, 1)),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Color.fromRGBO(99, 100, 167, 1),
              ),
              onPressed: () {
                signOut(context);
              },
            ),
          ]),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: !isloggedin
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(99, 100, 167, 1),
                  ),
                )
              : Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Container(
                          child: Image.asset(
                            'images/5.jpeg',
                            height: height * 0.25,
                            width: height * 0.25,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Video Call your Friends',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color.fromRGBO(99, 100, 167, 1),
                            ),
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            'images/2.jpeg',
                            height: height * 0.25,
                            width: height * 0.25,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Chat with your Friends',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color.fromRGBO(99, 100, 167, 1),
                            ),
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            'images/3.jpeg',
                            height: height * 0.25,
                            width: height * 0.25,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Add you Events',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color.fromRGBO(99, 100, 167, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
