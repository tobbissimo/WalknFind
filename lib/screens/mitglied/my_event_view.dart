import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/event.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

import 'new_event.dart';

//This is the Event details screen for my Events. Should only be accessible if you own the event.
//TODO There is practically no UI
class MyEventView extends StatefulWidget {
  final Event event;
  MyEventView({this.event});

  @override
  _MyEventViewState createState() => _MyEventViewState();
}

class _MyEventViewState extends State<MyEventView> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService db = DatabaseService(uid: user.uid);
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
                RaisedButton(
                    child: Text('Edit Event'),
                    onPressed: () => setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewEvent(event: widget.event)));
                    })
                ),
//                RaisedButton(
//                    child: Text('Anzeige deaktivieren'),
//                    onPressed: (() => db);
//                ),
                RaisedButton(
                    child: Text('Delete Event'),
                    onPressed: (() => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Sicher?'),
                          content: Text('Wirklich löschen?'),
                          actions: <Widget>[
                          FlatButton(
                            child: Text('Ja'),
                            onPressed: () {
                            Navigator.of(context).pop();
                            db.deleteEvent(widget.event.id);
                          }
                          ),
                          FlatButton(
                            child: Text('Nein'),
                            onPressed: () => Navigator.of(context).pop()
                          ),
                          ],
                        );
                      })
                  )
                ),
              ],
            ),
          ),
    );
  }
}
