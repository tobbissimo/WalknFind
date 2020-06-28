import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/event.dart';
import 'package:walkandfind/models/raum.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

import 'new_event.dart';
import 'new_room.dart';

//This is the Event details screen for my Events. Should only be accessible if you own the event.
//TODO There is practically no UI
class MyRoomView extends StatefulWidget {
  final Room room;
  MyRoomView({this.room});

  @override
  _MyRoomViewState createState() => _MyRoomViewState();
}

class _MyRoomViewState extends State<MyRoomView> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService db = DatabaseService(uid: user.uid);
    return Scaffold(
      body: Container(
        decoration: background,
        child: ListView(
          children: <Widget>[
            Text(widget.room.title),
            SizedBox(height: 6),
            Text(widget.room.type),
            SizedBox(height: 6),
            Text(widget.room.begin.toDate().toString()),
            SizedBox(height: 6),
            Text('Adresse: ' + widget.room.address),
            SizedBox(height: 6),
            Text('Price: €' + widget.room.price.toString()),
            SizedBox(height: 6),
            Text(widget.room.description),
            SizedBox(height: 6),
            Text(widget.room.saved.length.toString() + ' People are going'),
            SizedBox(height: 6),
            Image.network(widget.room.foto),
            SizedBox(height: 6),
            RaisedButton(
                child: Text('Edit room'),
                onPressed: () => setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewRoom(room: widget.room)));
                })
            ),
//                RaisedButton(
//                    child: Text('Anzeige deaktivieren'),
//                    onPressed: (() => db);
//                ),
            RaisedButton(
                child: Text('Delete room'),
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
                                db.deleteRoom(widget.room.id);
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
