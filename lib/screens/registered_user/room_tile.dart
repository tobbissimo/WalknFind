import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/raum.dart';
import 'package:walkandfind/screens/mitglied/my_room_view.dart';
import 'package:walkandfind/screens/registered_user/room_view.dart';

//This File has two classes
//The first class makes a single List tile based on a room
//The second class makes a list out of all the tiles
//That list is then sent to the Room List class
class RoomTile extends StatelessWidget {

  final Room room;
  final String uid;
  RoomTile({this.room, this.uid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          //contentPadding: EdgeInsets.all(15),
          trailing: Image.network('https://medicitv-b.imgix.net/movie/zaryadye-concert-hall-grand-opening_d_iDyUWrY.jpg?auto=format&q=85'),
          title: Text(room.title),
          subtitle: Text(room.type),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => uid == room.uid ? MyRoomView(room: this.room,) :RoomView(room: this.room))),
          //onTap: Navigator.push(context, route), open a details screen
        ),
      ),
    );
  }
}

class RoomTileList extends StatefulWidget {
  final String search;
  final String uid;
  RoomTileList({this.search, this.uid});

  @override
  _RoomTileListState createState() => _RoomTileListState();
}

class _RoomTileListState extends State<RoomTileList> {
  @override
  Widget build(BuildContext context) {
    final rooms = Provider.of<List<Room>>(context) ?? [];
    List roomsFiltered = List<Room>();
      if (widget.search != null && widget.search != '') {
        rooms.forEach((r) {
          if (r.type.toLowerCase().contains(widget.search.toLowerCase()) ||
              r.title.toLowerCase().contains(widget.search.toLowerCase())) {
            roomsFiltered.add(r);
          }
        });
      } else {
        roomsFiltered = rooms;
      }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: roomsFiltered.length,
        itemBuilder: (context, index) {
          return RoomTile(room: roomsFiltered[index], uid: widget.uid,);
        }
    );
  }
}
