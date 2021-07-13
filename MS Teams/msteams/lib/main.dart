import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:msteams/Screens/LaunchScreen.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  // ignore: unused_local_variable
  FirebaseApp app = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: LaunchScreen(),
    );
  }
}
