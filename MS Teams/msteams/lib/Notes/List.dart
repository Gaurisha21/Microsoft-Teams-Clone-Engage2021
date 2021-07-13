import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:msteams/Notes/Create.dart';
import 'package:msteams/Screens/drawer.dart';

class NotesList extends StatefulWidget {
  final String currentUserId;
  NotesList({Key? key, required this.currentUserId}) : super(key: key);
  @override
  createState() => _NotesListState(currentUserId: currentUserId);
}

class _NotesListState extends State<NotesList> {
  final String currentUserId;
  // ignore: unused_element
  _NotesListState({Key? key, required this.currentUserId});

  User? user;

  userF() async {
    User? firestore = await FirebaseAuth.instance.currentUser!;
    await firestore.reload();
    firestore = await FirebaseAuth.instance.currentUser!;
    setState(() {
      this.user = firestore!;
    });
  }

  // CalendarFormat format = CalendarFormat.month;
  // DateTime selectedDay = DateTime.now();
  // DateTime focusedDay = DateTime.now();
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.userF();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print(user?.uid);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(99, 100, 167, 1)),
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
        title: Text(
          'Add Note',
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
        child: Column(
          children: [
            Container(
              child: Image.asset(
                'images/6.jpeg',
                height: height * 0.25,
                width: height * 0.25,
              ),
            ),
            Divider(
              indent: width * 0.1,
              endIndent: width * 0.1,
              color: Colors.black54,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Notes')
                    .where('UserId', isEqualTo: user?.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs
                          .map((e) => Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                99, 100, 167, 1))),
                                    child: ExpansionTile(
                                        title: Text(e["Title"]),
                                        children: [
                                          ListTile(
                                            subtitle: Text(e["Date"]
                                                    .toString()
                                                    .substring(0, 11) +
                                                "\n" +
                                                e["Description"]),
                                          ),
                                        ]),
                                  ),
                                ],
                              ))
                          .toList(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(99, 100, 167, 1),
        children: [
          SpeedDialChild(
              child: Icon(Icons.note_add_outlined, color: Colors.white),
              label: 'Add Note',
              backgroundColor: Color.fromRGBO(99, 100, 167, 1),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Notes()));
              }),
        ],
      ),
    );
  }
}
