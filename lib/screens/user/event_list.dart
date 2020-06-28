import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/event.dart';
import 'package:walkandfind/screens/user/event_tile.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';
import 'package:walkandfind/models/user.dart';

//Lists all Events from the database. Gets the list from the event_tile Class.
//There is still no filter function.
class EventList extends StatefulWidget {
  final String events;
  EventList({this.events});

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  String _search;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Event>>.value(
      value:  widget.events == null ? DatabaseService().events:
      widget.events == 'meine' ? DatabaseService(uid: user.uid).myEvents :
      DatabaseService(uid: user.uid).mySavedEvents ,
      child: Scaffold(
        body:  Container(
          decoration: background,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.red[100],
                    hintText: 'Suche z.B. Konzert',
                  ),
                  onChanged: (val) => setState(() => _search = val),
                ),
              ),
                 EventTileList(search: _search, uid: user?.uid,),
            ],
          ),
        ),
      ),
    );
  }
}
