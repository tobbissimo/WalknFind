import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/equipment.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

//TODO UI
class EquipmentView extends StatefulWidget {
  final Equipment equipment;

  EquipmentView({this.equipment});

  @override
  _EquipmentViewState createState() => _EquipmentViewState();
}

class _EquipmentViewState extends State<EquipmentView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    bool saved;
    DatabaseService db = DatabaseService(uid: user.uid);
    widget.equipment.saved.contains(user.uid) ? saved = true : saved = false;
    return Scaffold(
        body: Container(
            decoration: background,
            child: ListView(
              children: <Widget>[
                Text(widget.equipment.title),
                SizedBox(height: 6),
                Text(widget.equipment.price.toString()),
                SizedBox(height: 6),
                Text(widget.equipment.address),
                SizedBox(height: 6),
                Text(widget.equipment.description),
                Image.network('https://medicitv-b.imgix.net/movie/zaryadye-concert-hall-grand-opening_d_iDyUWrY.jpg?auto=format&q=85'),
                saved ?
                RaisedButton(
                    child: Text('Remove from my list'),
                    onPressed: () => setState(() {
                      widget.equipment.saved.remove(widget.equipment.uid);
                      db.removeSavedEquipment(widget.equipment.id);
                    })
                ) :
                RaisedButton(
                    child: Text('Add to my list'),
                    onPressed: () => setState(() {
                      widget.equipment.saved.add(widget.equipment.uid);
                      db.updateSavedEquipment(widget.equipment.id);
                    })
                ),
              ],
            )
        )
    );
  }
}
