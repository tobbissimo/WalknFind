import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/screens/loading.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

//Don't have an account, here you make one
//TODO The layout still has to be fixed a bit. I fucked it up when I was trying something
class UserEdit extends StatefulWidget {

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {

  final _formkey = GlobalKey<FormState>();

  bool _loading = false;
  String _vorname = '';
  String _nachname = '';
  String _email = '';
  String _tel = '';
  //bool _mitglied = user.
  String _error;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DatabaseService db = DatabaseService(uid: user.uid);
    return _loading ? Loading() : StreamBuilder(
        stream: db.userData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            UserData userData = snapshot.data;
            _vorname = userData.firstName ?? '';
            _nachname = userData.lastName ?? '';
            _email = userData.email ?? '';
            _tel = userData.tel ?? '';
            return Scaffold(
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
                            Text('Edit Profile'),
                            SizedBox(height: 20.0,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: _vorname,
                                decoration: InputDecoration(
                                  hintText: 'Vorname',
                                ),
                                validator: (val) =>
                                val.isEmpty
                                    ? 'Enter a name'
                                    : null,
                                onChanged: (val) {
                                  _vorname = val;
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
                                initialValue: _nachname,
                                validator: (val) =>
                                val.isEmpty
                                    ? 'enter a name'
                                    : null,
                                onChanged: (val) {
                                  _nachname = val;
                                },
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: _email,
                                decoration: InputDecoration(
                                  hintText: 'email',
                                ),
                                validator: (val) =>
                                val.isEmpty
                                    ? 'enter a valid email address'
                                    : null,
                                onChanged: (val) {
                                  _email = val;
                                },
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: _tel,
                                decoration: InputDecoration(
                                  hintText: 'Telefonnummer (Optional)',
                                ),
                                onChanged: (val) {
                                  _tel = val;
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            RaisedButton(
                              elevation: 16,
                              disabledColor: Colors.red[900],
                              color: Colors.red,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)
                              ),
                              child: Text('Update'),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() => _loading = true);
                                  dynamic result = await db.updateUserData(_vorname, _nachname, _email, _tel, true);
                                  setState(() => _loading = false);
                                  Navigator.pop(context);
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
          } else {
            return Loading();
          }
    });
  }
}