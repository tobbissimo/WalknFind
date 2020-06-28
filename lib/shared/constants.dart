import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


var raisedButton = RaisedButton(
  elevation: 16,
  disabledColor: Colors.red,
  color: Colors.red,
  textColor: Colors.white,
  child: Text(''),
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.red),
    ),
);

var alertDialog = AlertDialog(
  title: Text('Oh no!'),
  content: Text('Something went wrong...'),
  actions: <Widget>[
    FlatButton(
        child: Text('OK'),
    ),
  ],
);

const background= BoxDecoration(
  image: DecorationImage(
  image: AssetImage('assets/Karte_rot.png'),
  fit: BoxFit.cover
  )
);

