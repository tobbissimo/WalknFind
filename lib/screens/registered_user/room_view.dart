import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/raum.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

//TODO This is the Room details screen, where you should also be able to save the room to your collection
//Probably best to save the document id in a subcollection under the user
class RoomView extends StatefulWidget {
  final Room room;

  RoomView({this.room});

  @override
  _RoomViewState createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    bool saved;
    DatabaseService db = DatabaseService(uid: user.uid);
    widget.room.saved.contains(user.uid) ? saved = true : saved = false;
    return Scaffold(
        body: Container(
            decoration: background,
            child: ListView(
              children: <Widget>[
                Text(widget.room.title),
                SizedBox(height: 6),
                Text(widget.room.type),
                SizedBox(height: 6),
                Text(widget.room.price?.toString()),
                SizedBox(height: 6),
                Text(widget.room.address),
                SizedBox(height: 6),
                Text(widget.room.begin?.toDate().toString()),
                SizedBox(height: 6),
                Text(widget.room.description),
                SizedBox(height: 6),
                Image.network('https://medicitv-b.imgix.net/movie/zaryadye-concert-hall-grand-opening_d_iDyUWrY.jpg?auto=format&q=85'),
                saved ?
                RaisedButton(
                    child: Text('Remove from my list'),
                    onPressed: () => setState(() {
                      widget.room.saved.remove(user.uid);
                      db.removeSavedRooms(widget.room.id);
                    })
                ) :
                RaisedButton(
                    child: Text('Add to my list'),
                    onPressed: () => setState(() {
                      widget.room.saved.add(user.uid);
                      db.updateSavedRooms(widget.room.id);
                    })
                ),
              ],
            )
        )
    );
  }
}
