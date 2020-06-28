import 'package:flutter/material.dart';
import 'package:walkandfind/services/auth.dart';
import 'package:walkandfind/screens/loading.dart';
import 'package:walkandfind/shared/constants.dart';

//Don't have an account, here you make one
//TODO The layout still has to be fixed a bit. I fucked it up when I was trying something
class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  bool _loading = false;
  String _vorname;
  String _nachname;
  String _email;
  String _tel;
  String _pwd;
  String _pwdConfirm;
  String _error;
  bool _mitglied = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? Loading() : Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Text('Anmeldungsformular'),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Vorname',
                      ),
                      validator: (val) => val.isEmpty ? 'Enter a name' : null,
                      onChanged: (val) {
                        setState(() {
                          _vorname = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Nachname',
                      ),
                      validator: (val) => val.isEmpty ? 'enter a name' : null,
                      onChanged: (val) {
                        setState(() {
                          _nachname = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'email',
                      ),
                      validator: (val) => val.isEmpty ? 'enter a valid email address' : null,
                      onChanged: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Telefonnummer (Optional)',
                      ),
                      onChanged: (val) {
                        setState(() {
                          _tel = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (val) => val.isEmpty ? 'enter a password' : null,
                      onChanged: (val) {
                        setState(() {
                          _pwd = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                      ),
                      validator: (val) => val != _pwd ? 'Passwords do not match' : null,
                      onChanged: (val) {
                        setState(() {
                          _pwdConfirm = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                          value: _mitglied,
                          onChanged:(bool value){
                            setState(() {
                              _mitglied = value;
                            });
                          }
                      ),
                      Text('Bist du ein Vereinsmitglied?')
                    ],
                  ),
                  RaisedButton(
                    elevation: 16,
                    disabledColor: Colors.red[900],
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)
                    ),
                    child: Text('Register'),
                    onPressed: () async {
                      if(_formkey.currentState.validate()) {
                          setState(() => _loading = true);
                          dynamic result = await _auth.register(_vorname, _nachname, _email, _tel, _pwd, _mitglied);
                          //print('Sign in pressed, Method empty');
                          if(result == null) {
                            setState(() {
                            _error = 'Registrierung fehler';
                            _loading = false;
                            });
                          } else {
                          _loading = false;
                          Navigator.pop(context);
                          }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
