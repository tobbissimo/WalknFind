import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/equipment.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';
import 'equipment_tile.dart';

//Lists all Equipment from the database. Gets the list from the Equipment Tile Class.
//Maybe this class should be under the mitglied folder?
class EquipmentList extends StatefulWidget {
  final String equipment;
  EquipmentList({this.equipment});

  @override
  _EquipmentListState createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {
  String _search;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Equipment>>.value(
      value:  widget.equipment == 'all' ? DatabaseService().equipment:
      widget.equipment == 'meine' ? DatabaseService(uid: user.uid).myEquipment :
      DatabaseService(uid: user.uid).mySavedEquipment ,
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
                    hintText: 'Suche z.B. Lautsprecher',
                  ),
                  onChanged: (val) => setState(() => _search = val),
                ),
              ),
              EquipmentTileList(search: _search,uid: user.uid),
            ],
          ),
        ),
      ),
    );
  }
}
