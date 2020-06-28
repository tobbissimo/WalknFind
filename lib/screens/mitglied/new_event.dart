import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';
import 'package:walkandfind/models/event.dart';

//TODO Think we should remove the dateTo datepicker and put in a timepicker instead or find a way to show the time at least
class NewEvent extends StatefulWidget {
  final Event event;
  NewEvent({this.event});
  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  final _formkey = GlobalKey<FormState>();
  DateTime _dateFrom = DateTime.now();
  DateTime _dateTo = DateTime.now();
  String _title;
  String _preis ;
  String _adresse;
  String _beschreibung;
  String _artderveranstaltung;
  String _error = '';
  String _id;

  final List<String> arten = [
    'Konzert', 'Theater', 'Kunst', 'Other'
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
    if(widget.event != null) {
      _dateFrom = widget.event.begin.toDate() ?? DateTime.now();
      _dateTo = widget.event.end.toDate() ?? DateTime.now();
      _title = widget.event.title ?? '';
      _preis = widget.event.price.toString() ?? '';
      _adresse = widget.event.address ?? '';
      _beschreibung = widget.event.description ?? '';
      _artderveranstaltung = widget.event.type ?? null;
      _id = widget.event.id ?? null;
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
            child: Form(
              key: _formkey,
            child: ListView(
              shrinkWrap: true,
              padding:  const EdgeInsets.all(20.0),
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Image(
                    image: AssetImage('assets/wnf_logo_klein.png'),
                  ),
                  title: Text('Deine neue Veranstaltung'),
                ),
                SizedBox(height: 20),
                Text('Titel'),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Titel',
                  ),
                  initialValue: _title,
                  validator: (val) => val.length < 3 ? 'Enter a title': null,
                  onChanged: (val) => setState(() => _title = val),
                ),
                SizedBox(height: 20),
                Center(
                  child: DropdownButton(
                    hint: Text('Art der Veranstaltung'),
                    value: _artderveranstaltung,
                    items: arten.map((art) {
                      return DropdownMenuItem(
                        value: art,
                        child: Text('$art' ?? 'null'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _artderveranstaltung = val),
                  ),
                ),
                SizedBox(height: 20),
                Text('Kartenpreis'),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: '0-999€'
                  ),
                  initialValue: _preis,
                  validator: (val) => val.isEmpty ? 'enter a price': null,
                  onChanged: (val) => setState(() => _preis = val),
                ),
                SizedBox(height: 20),
                Text('Adresse'),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Rathaus 1-2/2/2, 1010 Wien'
                  ),
                  initialValue: _adresse,
                  validator: (val) => val.length <2 ? 'enter an address' : null,
                  onChanged: (val)  => setState(() => _adresse = val),
                ),
                SizedBox(height: 20),
                Text('Beschreibung'),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Kurze Beschreibung'
                  ),
                  initialValue: _beschreibung,
                  onChanged: (val) => setState(() => _beschreibung = val ?? ''),
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
                          child: Text('Findet statt ab'),
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
                          child: Center(
                              child: Text(DateFormat('d.MM.y').format(_dateFrom) + ' '),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: (){
                            callDatePickerTo();
                          },
                          child: Text('Dauert bis'),
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
                          child: Center(
                              child: Text(DateFormat('d.MM.y').format(_dateTo) + ' '),
                          ),
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
                          if(_formkey.currentState.validate()) {
                            bool result = await DatabaseService(uid: user.uid)
                                .updateEventData(
                                _title,
                                _artderveranstaltung,
                                _beschreibung,
                                _dateFrom,
                                _dateTo,
                                _adresse,
                                '0.0.0',
                                user.email,
                                _preis,
                                null,
                                _id);
                            if (result) {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Success!'),
                                    content: Text(
                                        'Veranstaltung veröffentlicht'),
                                    actions: <Widget>[
                                      FlatButton(
                                          child: Text('OK'),
                                          onPressed: () =>
                                              Navigator.of(context).pop()
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
                                          onPressed: () =>
                                              Navigator.of(context).pop()
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        }
                    ),
                    RaisedButton(
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Abbrechen'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}