import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/equipment.dart';
import 'package:walkandfind/screens/mitglied/my_equipment_view.dart';
import 'package:walkandfind/screens/registered_user/equipment_view.dart';

//This File has two classes
//The first class makes a single List tile based on an Equipment
//The second class makes a list out of all the tiles
//The list is then sent to the Equipment List class
class EquipmentTile extends StatelessWidget {

  final Equipment equipment;
  final String uid;
  EquipmentTile({this.equipment, this.uid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          //contentPadding: EdgeInsets.all(15),
          trailing: Image.network('https://medicitv-b.imgix.net/movie/zaryadye-concert-hall-grand-opening_d_iDyUWrY.jpg?auto=format&q=85'),
          title: Text(equipment.title),
          subtitle: Text(equipment.price.toString()),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => uid == equipment.uid ? MyEquipmentView(equipment: this.equipment) : EquipmentView(equipment: this.equipment))),
          //onTap: Navigator.push(context, route), open a details screen
        ),
      ),
    );
  }
}

class EquipmentTileList extends StatefulWidget {
  String search;
  String uid;
  EquipmentTileList({this.search, this.uid});

  @override
  _EquipmentTileListState createState() => _EquipmentTileListState();
}

class _EquipmentTileListState extends State<EquipmentTileList> {
  @override
  Widget build(BuildContext context) {
    final equipment = Provider.of<List<Equipment>>(context) ?? [];
    List equipmentFiltered = List<Equipment>();
      if (widget.search != null && widget.search != '') {
        equipment.forEach((e) {
          if (e.title.toLowerCase().contains(widget.search.toLowerCase())) {
            equipmentFiltered.add(e);
          }
        });
      } else {
        equipmentFiltered = equipment;
      }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: equipmentFiltered.length,
        itemBuilder: (context, index) {
          return EquipmentTile(equipment: equipmentFiltered[index], uid: widget.uid,);
        }
    );
  }
}
