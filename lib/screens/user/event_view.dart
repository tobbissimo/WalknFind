import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/event.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

//This is the Event details screen, where you can also mark yourself as attending
//TODO The UI needs to be fixed
class EventView extends StatefulWidget {
  final Event event;
  EventView({this.event});

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    bool attending;
    DatabaseService db = DatabaseService(uid: user?.uid);
    widget.event.attending.contains(user?.uid) ? attending = true : attending = false;
    return Scaffold(
      body: Container(
        decoration: background,
        child: ListView(
          children: <Widget>[
            Text(widget.event.title),
            SizedBox(height: 6),
            Text(widget.event.type),
            SizedBox(height: 6),
            Text(widget.event.begin.toDate().toString()),
            SizedBox(height: 6),
            Text('Adresse: ' + widget.event.address),
            SizedBox(height: 6),
            Text('Price: €' + widget.event.price.toString()),
            SizedBox(height: 6),
            Text(widget.event.description),
            SizedBox(height: 6),
            Text(widget.event.attending.length.toString() + ' People are going'),
            SizedBox(height: 6),
            Image.network(widget.event.foto),
            SizedBox(height: 6),
            user == null ?
                //if user is null, then no one is logged in and button is disabled
            RaisedButton(
                child: Text('Log in to attend!'),
                onPressed: () => null
            ) :
            attending ?
            RaisedButton(
                child: Text('Not going'),
                onPressed: () => setState(() {
                  widget.event.attending.remove(user.uid);
                  db.removeSavedEvents(widget.event.id);
                })
            ) :
            RaisedButton(
                child: Text('Going'),
                onPressed: () => setState(() {
                  widget.event.attending.add(user.uid);
                  db.updateSavedEvents(widget.event.id);
                })
            ),
            RaisedButton(
                child: Text('Who\'s going?'),
                onPressed: (() => widget.event.printList())
            ),
          ],
        )
      )
    );
  }
}
