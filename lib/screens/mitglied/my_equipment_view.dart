import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/equipment.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/screens/mitglied/new_equipment.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

import 'new_event.dart';

//This is the Event details screen for my Events. Should only be accessible if you own the event.
//TODO There is practically no UI
class MyEquipmentView extends StatefulWidget {
  final Equipment equipment;
  MyEquipmentView({this.equipment});

  @override
  _MyEquipmentViewState createState() => _MyEquipmentViewState();
}

class _MyEquipmentViewState extends State<MyEquipmentView> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService db = DatabaseService(uid: user.uid);
    return Scaffold(
      body: Container(
        decoration: background,
        child: ListView(
          children: <Widget>[
            Text(widget.equipment.title),
            SizedBox(height: 6),
            Text(widget.equipment.email),
            SizedBox(height: 6),
            Text('Adresse: ' + widget.equipment.address),
            SizedBox(height: 6),
            Text('Price: €' + widget.equipment.price.toString()),
            SizedBox(height: 6),
            Text(widget.equipment.description),
            SizedBox(height: 6),
            Text(widget.equipment.saved.length.toString() + ' People have saved this'),
            SizedBox(height: 6),
            Image.network(widget.equipment.foto),
            SizedBox(height: 6),
            RaisedButton(
                child: Text('Edit Equipment'),
                onPressed: () => setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewEquipment(equipment: widget.equipment)));
                })
            ),
//                RaisedButton(
//                    child: Text('Anzeige deaktivieren'),
//                    onPressed: (() => db);
//                ),
            RaisedButton(
                child: Text('Delete Equipment'),
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
                                db.deleteEquipment(widget.equipment.id);
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
