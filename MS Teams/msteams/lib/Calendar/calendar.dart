import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:msteams/Calendar/calendar_firestore.dart';
import 'package:msteams/Screens/drawer.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final String currentUserId;
  Calendar({Key? key, required this.currentUserId}) : super(key: key);
  @override
  _CalendarState createState() => _CalendarState(currentUserId: currentUserId);
}

class _CalendarState extends State<Calendar> {
  final String currentUserId;
  // ignore: unused_element
  _CalendarState({Key? key, required this.currentUserId});

  User? user;

  userF() async {
    User? firestore = await FirebaseAuth.instance.currentUser!;
    await firestore.reload();
    firestore = await FirebaseAuth.instance.currentUser!;
    setState(() {
      this.user = firestore!;
    });
  }

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: '',
      description: '',
      location: '',
      startDate: selectedDay,
      endDate: selectedDay.add(Duration(minutes: 30)),
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 40),
      ),
      androidParams: AndroidParams(
        emailInvites: ["test@example.com"],
      ),
      recurrence: recurrence,
    );
  }

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
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

  @override
  Widget build(BuildContext context) {
    print(user?.uid);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(99, 100, 167, 1)),
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
        title: Text(
          'Add Reminder',
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
            Card(
              margin: const EdgeInsets.all(10.0),
              child: TableCalendar(
                focusedDay: selectedDay,
                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekVisible: true,
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(fontWeight: FontWeight.w500),
                    weekendStyle: TextStyle(fontWeight: FontWeight.w500)),
                //Day Changed
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                  print(focusedDay);
                },
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },
                //To style the Calendar
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: Color.fromRGBO(99, 100, 167, 1),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        color: Color.fromRGBO(99, 100, 167, 1), width: 2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  todayTextStyle: TextStyle(color: Colors.black),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                headerStyle: HeaderStyle(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(99, 100, 167, 1)),
                  headerMargin: const EdgeInsets.only(bottom: 8),
                  formatButtonVisible: true,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  formatButtonShowsNext: false,
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user')
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
                                        title: Text(e["Title"] +
                                            ", " +
                                            (e["Start Date"])
                                                .toString()
                                                .substring(0, 11)),
                                        children: [
                                          ListTile(
                                            subtitle: Text("Starts At:   " +
                                                (e["Start Date"])
                                                    .toString()
                                                    .substring(0, 11) +
                                                ", " +
                                                (e["Start Date"])
                                                    .toString()
                                                    .substring(11, 16) +
                                                "\n" +
                                                "Ends At:   " +
                                                (e["End Date"])
                                                    .toString()
                                                    .substring(0, 11) +
                                                ", " +
                                                (e["End Date"])
                                                    .toString()
                                                    .substring(11, 16) +
                                                "\n" +
                                                "Meeting Channel:   " +
                                                (e["Meeting Channel"]) +
                                                "\n\n" +
                                                (e["Description"])),
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
              child: Icon(
                Icons.event_available,
                color: Colors.white,
              ),
              label: 'Phone Calendar',
              backgroundColor: Color.fromRGBO(99, 100, 167, 1),
              onTap: () {
                Add2Calendar.addEvent2Cal(buildEvent());
              }),
          SpeedDialChild(
              child: Icon(Icons.event_available_outlined, color: Colors.white),
              label: 'App Calendar',
              backgroundColor: Color.fromRGBO(99, 100, 167, 1),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => calFir()));
              }),
        ],
      ),
    );
  }
}
