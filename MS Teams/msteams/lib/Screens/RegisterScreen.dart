import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:msteams/Chat/user_chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePageScreen.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late User user;
  bool isloggedin = false;
  SharedPreferences? prefs;
  User? currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _name, _email, _password;

  checkAuthentication() async {
    await _auth.authStateChanges().listen((user) async {
      if (user != null) {
        print(user);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePageScreen(
                    currentUserId: prefs?.getString('id') ?? "")));
      }
    });
  }

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

  @override
  void initState() {
    super.initState();
    this.getUser().whenComplete(() {
      setState(() {});
    });
  }

  Future signUp(context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        // ignore: unnecessary_null_comparison
        if (user != null) {
          await _auth.currentUser!.updateDisplayName(_name);
        }
      } on FirebaseAuthException catch (e) {
        showError(e.message);
        print(e);
      }

      User? firebaseUser = (await FirebaseAuth.instance.currentUser);
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePageScreen(currentUserId: prefs?.getString('id') ?? "")));
  }

  showError(String? message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(message!),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Future navigateToLogin(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
                  padding: EdgeInsets.fromLTRB(
                      10, height * 0.015, 10, height * 0.06),
                ),
                Container(
                  child: new Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                              validator: (input) {
                                if (input == null || input.isEmpty)
                                  return 'Enter Name';
                              },
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  prefixIcon: Icon(Icons.person)),
                              onSaved: (input) => _name = input!),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                              validator: (input) {
                                if (input == null || input.isEmpty)
                                  return 'Enter Email';
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email)),
                              onSaved: (input) => _email = input!),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                              validator: (input) {
                                if (input == null || input.length < 6)
                                  return 'Provide Minimum 6 Character';
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                              onSaved: (input) => _password = input!),
                        ),
                        SizedBox(height: height * 0.04),
                        ElevatedButton(
                          onPressed: () {
                            signUp(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(99, 100, 167, 1),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.fromLTRB(width * 0.35,
                                height * 0.012, width * 0.35, height * 0.012),
                          ),
                          child: Text('SIGN UP',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(height: height * 0.02),
                        GestureDetector(
                          child: Text('Already have an Account?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black54),
                              textAlign: TextAlign.center),
                          onTap: () {
                            navigateToLogin(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ])),
        ));
  }
}
