import 'package:flutter/material.dart';
import 'package:walkandfind/screens/loading.dart';
import 'package:walkandfind/services/auth.dart';
import 'package:walkandfind/shared/constants.dart';

//Here you sign in if you have an account
//TODO The layout still has to be fixed a bit. I fucked it up when I was trying something
class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool _loading = false;

  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return _loading ? Loading() : Scaffold(
      body: Container(
        decoration: background,
        child: Form(
          key: _formkey,
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(40, 60, 40, 35),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0),
                  )
              ),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Text('Hast scho a Account? Log dich doch ein!'),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      onChanged: (val) => setState(() => _email = val.trim(),
                      ),
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
                      validator: (val) => val.isEmpty ? 'Enter a Password' : null,
                      onChanged: (val) => setState(() => _password = val),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red),
                      ),
                    child: Text('Sign in'),
                    onPressed: () async {
                      if(_formkey.currentState.validate()) {
                        setState(() => _loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
                        if(result == null) {
                          setState(() {
                            _error = 'Could not sign in with these credentials';
                            _loading = false;
                          });
                        } else {
                          _loading = false;
                          Navigator.pop(context);
                        }
                      }
                    },
                  ),
                  Text(_error, textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
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
