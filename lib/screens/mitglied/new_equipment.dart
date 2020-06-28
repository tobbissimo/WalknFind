import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:walkandfind/models/equipment.dart';
import 'package:walkandfind/models/user.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

class NewEquipment extends StatefulWidget {
  final Equipment equipment;
  NewEquipment({this.equipment});
  @override
  _NewEquipmentState createState() => _NewEquipmentState();
}

class _NewEquipmentState extends State<NewEquipment> {
  DateTime _dateFrom = DateTime.now();
  DateTime _dateTo = DateTime.now();
  String _title;
  String _preis;
  String _beschreibung;
  String _artderanzeige;
  String _adresse;
  String _id;

  final List<String> arten = [
    'Verkauf', 'Ausleih'
  ];

  void callDatePickerFrom() async {
    var order = await getDate();
    setState(() {
      _dateFrom = order;
    });
  }
  void callDatePickerTo() async {
    var order = await getDate();
    setState(() {
      _dateTo = order;
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if(widget.equipment != null) {
      _dateFrom = widget.equipment.begin.toDate() ?? DateTime.now();
      _dateTo = widget.equipment.end.toDate() ?? DateTime.now();
      _title = widget.equipment.title ?? '';
      _preis = widget.equipment.price.toString() ?? '';
      _beschreibung = widget.equipment.description ?? '';
      _artderanzeige = widget.equipment.type ?? '';
      _adresse = widget.equipment.address ?? '';
      _id = widget.equipment.id ?? null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      body: Container(
        decoration: background,
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(40, 60, 40, 35),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0),
                )
            ),
            child: ListView(
              shrinkWrap: true,
              padding:  const EdgeInsets.all(20.0),
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Image(
                    image: AssetImage('assets/wnf_logo_klein.png'),),
                  title: Text('Dein neues Equipment'),
                ),
                SizedBox(height: 20),
                Text('Titel'),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Titel',
                  ),
                  initialValue: _title,
                  validator: (val) => val.isEmpty ? 'enter a title' : null,
                  onChanged: (val) => setState(() => _title = val),
                ),
                SizedBox(height: 20),
                Center(
                  child: DropdownButton(
                    hint: Text('Art des Equipments'),
                    value: _artderanzeige ?? null,
                    items: arten.map((art) {
                      return DropdownMenuItem(
                        value: art,
                        child: Text('$art' ?? 'null'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _artderanzeige = val),
                  ),
                ),
                SizedBox(height: 20),
                Text('Preis'),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: '0-99999€'
                  ),
                  initialValue: _preis,
                  validator: (val) => val.isEmpty ? 'enter a price' : null,
                  onChanged: (val) => setState(() => _preis = val),
                ),
                SizedBox(height: 20),
                Text('Adresse'),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Rathaus 1-2/2/2, 1010 Wien'
                  ),
                  initialValue: _adresse,
                  validator: (val) => val.isEmpty ? 'enter an address' : null,
                  onChanged: (val) => setState(() => _adresse = val),
                ),
                SizedBox(height: 20),
                Text('Beschreibung'),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Kurze Beschreibung'
                  ),
                  initialValue: _beschreibung,
                  onChanged: (val) => setState(() =>_beschreibung = val ?? ''),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: (){
                            callDatePickerFrom();
                          },
                          child: Text('Verfügbar ab'),
                          elevation: 16,
                          disabledColor: Colors.red[900],
                          color: Colors.red,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Text(DateFormat('d.MM.y').format(_dateFrom) + ' ')),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: (){
                            callDatePickerTo();
                          },
                          child: Text('Verfügbar bis'),
                          elevation: 16,
                          disabledColor: Colors.red[900],
                          color: Colors.red,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Text(DateFormat('d.MM.y').format(_dateTo) + ' ')),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Veröffentlichen'),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                        onPressed: () async {
                          bool result = await DatabaseService(uid: user.uid)
                              .updateEquipmentData(_title, _beschreibung, _preis, _adresse, '00.00', '', _dateFrom, _dateTo, _artderanzeige, user.email, true, _id);
                          if (result == true) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Success!'),
                                  content: Text('Equipment veröffentlicht'),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text('OK'),
                                        onPressed: () => Navigator.of(context).pop()
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                //TODO Maybe try Snackbar instead of Alertdialog
                                return  AlertDialog(
                                  title: Text('Success!'),
                                  content: Text('Raum veröffentlicht'),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text('OK'),
                                        onPressed: () => Navigator.of(context).pop()
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                    ),
                    RaisedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Abbrechen'),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}