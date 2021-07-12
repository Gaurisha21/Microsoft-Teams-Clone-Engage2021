import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:msteams/Chat/user_chat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePageScreen.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SharedPreferences? prefs;
  User? currentUser;
  Future navigateToLogin(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future navigateToRegister(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  signInWithGoogle() async {
    prefs = await SharedPreferences.getInstance();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    User? firebaseUser =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    // return await FirebaseAuth.instance.signInWithCredential(credential);

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Update data to server if new user
        FirebaseFirestore.instance
            .collection('chat')
            .doc(firebaseUser.uid)
            .set({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoURL,
          'id': firebaseUser.uid,
          'createdAt': DateTime.now().toString(),
          'chattingWith': null
        });

        // Write data to local
        currentUser = firebaseUser;
        await prefs?.setString('id', currentUser!.uid);
        await prefs?.setString('nickname', currentUser!.displayName ?? "");
        await prefs?.setString('photoUrl', currentUser!.photoURL ?? "");
      } else {
        DocumentSnapshot documentSnapshot = documents[0];
        UserChat userChat = UserChat.fromDocument(documentSnapshot);
        // Write data to local
        await prefs?.setString('id', userChat.id);
        await prefs?.setString('nickname', userChat.nickname);
        await prefs?.setString('photoUrl', userChat.photoUrl);
        await prefs?.setString('aboutMe', userChat.aboutMe);
      }
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(currentUserId: firebaseUser.uid)));
    }
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
              child: Stack(children: [
            Column(
              children: [
                Container(
                  child: Text(
                    'Microsoft Teams',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        color: Colors.deepPurple[700]),
                  ),
                  padding: EdgeInsets.fromLTRB(
                      10, height * 0.140, 10, height * 0.0114),
                ),
                Container(
                  child: Image.asset(
                    'images/1.jpeg',
                    height: height * 0.245,
                    width: height * 0.245,
                  ),
                  padding: EdgeInsets.fromLTRB(
                      10, height * 0.028, 10, height * 0.0114),
                ),
                Container(
                  child: Text(
                      'Get started with your work, school, or\npersonal Microsoft account.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.black54),
                      textAlign: TextAlign.center),
                  padding:
                      EdgeInsets.fromLTRB(10, height * 0.015, 10, height * 0.1),
                ),
                ElevatedButton(
                  onPressed: () {
                    navigateToRegister(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(99, 100, 167, 1),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.fromLTRB(width * 0.315, width * 0.03,
                        width * 0.315, width * 0.03),
                  ),
                  child: Text('REGISTER',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                ElevatedButton(
                  onPressed: () {
                    navigateToLogin(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(99, 100, 167, 1),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.fromLTRB(
                        width * 0.35, width * 0.03, width * 0.35, width * 0.03),
                  ),
                  child: Text('LOGIN',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SignInButton(Buttons.Google, text: "Sign up with Google",
                    onPressed: () {
                  signInWithGoogle().whenComplete(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePageScreen(
                            currentUserId: prefs?.getString('id') ?? "")));
                  });
                }),
              ],
            ),
          ])),
        ));
  }
}
