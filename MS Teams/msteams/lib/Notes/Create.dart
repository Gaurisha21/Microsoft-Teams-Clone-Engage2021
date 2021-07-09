import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final _titleController = TextEditingController();
  final _DescController = TextEditingController();
  final _DateController =
      TextEditingController(text: DateTime.now().toString());
  bool _validateError = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    _titleController.dispose();
    _DescController.dispose();
    _DateController.dispose();
    super.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(99, 100, 167, 1)),
        elevation: 0.0,
        title: Text(
          'Add Note',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color.fromRGBO(99, 100, 167, 1)),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
          child: new Form(
              key: _formKey,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                    //Title
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 0),
                    child: TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.create_outlined),
                        fillColor: Color.fromRGBO(99, 100, 167, 1),
                        errorText: _validateError ? 'Title is mandatory' : null,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Title',
                      ),
                    )),
                Container(
                    //Description
                    margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: TextFormField(
                      controller: _DescController,
                      maxLines: 40,
                      minLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.feed_outlined),
                        fillColor: Color.fromRGBO(99, 100, 167, 1),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Note...',
                      ),
                    )),
              ]))),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromRGBO(99, 100, 167, 1),
        onPressed: () async {
          var firebaseUsed = await FirebaseAuth.instance.currentUser!;
          Map<String, dynamic> data = {
            "Description": _DescController.text,
            "Title": _titleController.text,
            "Date": _DateController.text,
            "UserId": firebaseUsed.uid,
          };
          FirebaseFirestore.instance.collection("Notes").doc().set(data);
          Navigator.pop(context);
        },
        label: Text("Add"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
