import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class calFir extends StatefulWidget {
  @override
  _calFirState createState() => _calFirState();
}

class _calFirState extends State<calFir> {
  final _titleController = TextEditingController();
  final _DescController = TextEditingController();
  final _vcController = TextEditingController();
  final _StartDteController =
      TextEditingController(text: DateTime.now().toString());
  final _EndDteController =
      TextEditingController(text: DateTime.now().toString());
  bool _validateError = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    _titleController.dispose();
    _StartDteController.dispose();
    _EndDteController.dispose();
    _DescController.dispose();
    _vcController.dispose();
    super.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          child: new Form(
              key: _formKey,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Container(
                    //Title
                    margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
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
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.feed_outlined),
                        fillColor: Color.fromRGBO(99, 100, 167, 1),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Description',
                      ),
                    )),
                Container(
                    //Meeting Channel
                    margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: TextFormField(
                      controller: _vcController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.video_call),
                        fillColor: Color.fromRGBO(99, 100, 167, 1),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Meeting Channel',
                      ),
                    )),
                Container(
                  //Start Date
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: DateTimePicker(
                    controller: _StartDteController,
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'dd MMMM, yyyy',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.event),
                    ),
                    dateLabelText: "Start Date",
                    timeLabelText: "Start Time",
                    onChanged: (val) => print(val),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
                Container(
                  //End Date
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: DateTimePicker(
                    controller: _EndDteController,
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'dd MMMM, yyyy',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.event),
                    ),
                    dateLabelText: "End Date",
                    timeLabelText: "End Time",
                    onChanged: (val) => print(val),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
              ]))),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromRGBO(99, 100, 167, 1),
        onPressed: () async {
          var firebaseUsed = await FirebaseAuth.instance.currentUser!;
          Map<String, dynamic> data = {
            "Description": _DescController.text,
            "End Date": _EndDteController.text,
            "Meeting Channel": _vcController.text,
            "Start Date": _StartDteController.text,
            "Title": _titleController.text,
            "UserId": firebaseUsed.uid,
          };
          FirebaseFirestore.instance.collection("user").doc().set(data);
          Navigator.pop(context);
        },
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
