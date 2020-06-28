import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/screens/mitglied/new_ad.dart';
import 'package:walkandfind/screens/registered_user/equipment_list.dart';
import 'package:walkandfind/screens/registered_user/newsfeed.dart';
import 'package:walkandfind/screens/registered_user/registered_user_view.dart';
import 'package:walkandfind/screens/registered_user/room_list.dart';
import 'package:walkandfind/screens/user/event_list.dart';
import 'package:walkandfind/screens/user/user_home.dart';
import 'package:walkandfind/services/auth.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

//This is the Screen that the user sees after he has signed in.
//Maybe we have to check if the user is a mitglied and then deactivate some buttons
//Bool mitglied is saved in the database
class RegisteredUserHome extends StatelessWidget {

  String name ='';

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return user == null ? UserHome() : StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
        name = userData?.firstName ?? '';
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
                      title: Text('Leiwand, dass du da bist, $name!'),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('User Feed'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisteredUserView()));
                      },
                    ),
                    RaisedButton(
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Nachrichten'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewsFeed()));
                      },
                    ),
                    RaisedButton(
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Anzeige erstellen'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewAd()));
                      },
                    ),
                    SizedBox(height: 20),
                    Center(child: Text('Willst du einen Pin erstellen?')),
                    SizedBox(height: 20),
                    RaisedButton(
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Veranstaltungen'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventList()));
                      },
                    ),
                    RaisedButton(
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Equipment'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EquipmentList(equipment: 'all',)));
                      },
                    ),
                    RaisedButton(
                      elevation: 16,
                      disabledColor: Colors.red[900],
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Räumlichkeiten'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RoomList(rooms: 'all')));
                      },
                    ),
                    Center(child: FlatButton(
                      onPressed: () async {
                          await _auth.signOut();
                      },
                      child: Text('Ausloggen'),
                    )),
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