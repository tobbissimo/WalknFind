import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/event.dart';
import 'package:walkandfind/screens/mitglied/my_event_view.dart';
import 'package:walkandfind/screens/user/event_view.dart';

//This File has two classes
//The first class makes a single List tile based on an event
//The second class makes a list out of all the tiles
//That list is then sent to the Event List class
class EventTile extends StatelessWidget {

  final Event event;
  final String uid;
  EventTile({this.event, this.uid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          //contentPadding: EdgeInsets.all(15),
          trailing: Image.network(event.foto),
          title: Text(event.title),
          subtitle: Text(event.begin.toDate().toString()),
          onTap: () => Navigator.push(
            //If its your event you get the myevent view screen and can edit stuff. Else you get the normal screen
              context, MaterialPageRoute(
              builder: (context) =>
              uid == null || uid != event.uid ? EventView(event: this.event) : MyEventView(event: this.event,)

          )
          ),
        ),
      ),
    );
  }
}

class EventTileList extends StatefulWidget {
  String search;
  String uid;
  EventTileList({this.search, this.uid});

  @override
  _EventTileListState createState() => _EventTileListState();
}

class _EventTileListState extends State<EventTileList> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<Event>>(context) ?? [];
    List eventsFiltered = List<Event>();
      if (widget.search != null && widget.search != '') {
        events.forEach((e) {
          if (e.type.toLowerCase().contains(widget.search.toLowerCase()) ||
              e.title.toLowerCase().contains(widget.search.toLowerCase())) {
            eventsFiltered.add(e);
          }
        });
      } else {
        eventsFiltered = events;
      }
    return ListView.builder(
      shrinkWrap: true,
        itemCount: eventsFiltered.length,
        itemBuilder: (context, index) {
          return EventTile(event: eventsFiltered[index], uid: widget.uid);
        }
    );
  }
}
