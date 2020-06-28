import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/raum.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

class NewRoom extends StatefulWidget {
  final Room room;
  NewRoom({this.room});
  @override
  _NewRoomState createState() => _NewRoomState();
}

class _NewRoomState extends State<NewRoom> {

  DateTime _dateFrom = DateTime.now();
  DateTime _dateTo = DateTime.now();
  String _title;
  String _artdesraeumes;
  String _beschreibung;
  String _groesse;
  String _preis;
  String _adresse;
  String _id;
  String error;

  final List<String> raumarten = [
    'Atelier', 'Veranstaltungssaal', 'Büro', 'Abstellraum', 'Other'
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
    if(widget.room != null) {
      _dateFrom = widget.room.begin?.toDate() ?? DateTime.now();
      _dateTo = widget.room.end?.toDate() ?? DateTime.now();
      _title = widget.room.title;
      _artdesraeumes = widget.room.type;
      _beschreibung = widget.room.description;
      _groesse = widget.room.size;
      _preis = widget.room.price?.toString();
      _adresse = widget.room.address;
      _id = widget.room.id ?? null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
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
                        image: AssetImage('assets/wnf_logo_klein.png'),
                      ),
                      title: Text('Deine neue Räumlichkeit'),
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
                        hint: Text('Art des Räumes'),
                        value: _artdesraeumes ?? null,
                        items: raumarten.map((raumart) {
                          return DropdownMenuItem(
                            value: raumart,
                            child: Text('$raumart' ?? 'null'),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _artdesraeumes = val),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Größe'),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'm²'
                      ),
                      initialValue: _groesse,
                        validator: (val) => val.isEmpty ? 'enter a size' : null,
                        onChanged: (val) => setState(() => _groesse = val),
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
                              onPressed: () => callDatePickerFrom(),
                              child: Text('Verfügbar ab'),
                              elevation: 16,
                              disabledColor: Colors.red[900],
                              color: Colors.red,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(child: Text(_dateFrom == null ? 'Ab (Pflichtfeld)' : 'Ab ' + DateFormat('d.MM.y').format(_dateFrom) + ' ')),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () => callDatePickerTo(),
                              child: Text('Verfügbar bis'),
                              elevation: 16,
                              disabledColor: Colors.red[900],
                              color: Colors.red,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(child: Text(_dateTo == null ? 'Bis' : 'Bis ' + DateFormat('d.MM.y').format(_dateTo) + ' ')),
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
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)
                          ),
                          onPressed: () async {
                            bool result = await DatabaseService(uid: user.uid)
                                  .updateRoomData(_id, _title, _beschreibung, _artdesraeumes, _groesse, _preis, '', _adresse, '0.0.0', user.email, _dateFrom, _dateTo);
                              if (result == true) {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
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
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Oh no!'),
                                      content: Text('Something went wrong...'),
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
                              borderRadius: BorderRadius.circular(18.0),
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
    );
  }
}