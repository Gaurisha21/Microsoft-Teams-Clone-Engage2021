import 'package:flutter/material.dart';
import 'package:msteams/Calendar/calendar.dart';
import 'package:msteams/Chat/contact.dart';
import 'package:msteams/Notes/List.dart';
import 'package:msteams/Screens/HomePageScreen.dart';
import 'package:msteams/pages/index.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final String currentUserId;
  NavigationDrawerWidget({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() =>
      _NavigationDrawerWidgetState(currentUserId: currentUserId);
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final String currentUserId;
  // ignore: unused_element
  _NavigationDrawerWidgetState({Key? key, required this.currentUserId});

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 25,
      ),
      title: Text(
        text,
        style: TextStyle(color: color, fontSize: 15),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePageScreen(
                      currentUserId: currentUserId,
                    )));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndexPage(
                      currentUserId: currentUserId,
                    )));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(currentUserId: currentUserId)));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Calendar(
                      currentUserId: currentUserId,
                    )));
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotesList(currentUserId: currentUserId)));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(99, 100, 167, 1),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'Video Call',
              icon: Icons.video_call,
              onClicked: () => selectedItem(context, 1),
            ),
            buildMenuItem(
              text: 'Chat',
              icon: Icons.chat,
              onClicked: () => selectedItem(context, 2),
            ),
            buildMenuItem(
              text: 'Reminders',
              icon: Icons.event,
              onClicked: () => selectedItem(context, 3),
            ),
            buildMenuItem(
              text: 'Notes',
              icon: Icons.note_add_outlined,
              onClicked: () => selectedItem(context, 4),
            ),
          ],
        ),
      ),
    );
  }
}
