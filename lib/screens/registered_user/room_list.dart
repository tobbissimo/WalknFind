import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/raum.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/screens/registered_user/room_tile.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

//Lists all rooms from the database. Gets the list from the room_tile Class.
//There is still no filter function.
//Maybe this class should be under the mitglied folder?
class RoomList extends StatefulWidget {
  final String rooms;
  RoomList({this.rooms});

  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  String _search;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Room>>.value(
      value:  widget.rooms == 'all' ? DatabaseService().rooms:
      widget.rooms == 'meine'? DatabaseService(uid: user.uid).myRooms :
      DatabaseService(uid: user.uid).mySavedRooms ,
      child: Scaffold(
        body: Container(
          decoration: background,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.red[100],
                    hintText: 'Suche z.B. Saal',
                  ),
                  onChanged: (val) => setState(() => _search = val),
                ),
              ),
              RoomTileList(search: _search, uid: user.uid,),
            ],
          ),
        ),
      ),
    );
  }
}
