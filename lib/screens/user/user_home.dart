import 'package:flutter/material.dart';
import 'package:walkandfind/authenticate/register.dart';
import 'package:walkandfind/authenticate/sign_in.dart';
import 'package:walkandfind/screens/registered_user/newsfeed.dart';
import 'package:walkandfind/screens/user/event_list.dart';
import 'package:walkandfind/screens/user/user_view.dart';
import 'package:walkandfind/shared/constants.dart';

//This is the screen everyone sees when they haven't signed in. I got rid of the splash screen as I thought this made more sense
//All you can do in this screen is look at Events and go to the login and register screens
class UserHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: background,
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(Radius.circular(20.0),
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
                  title: Text('Leiwand, dass du da bist!'),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EventList()));
                  },
                  elevation: 16,
                  disabledColor: Colors.red[900],
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Veranstaltungen'),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  ),
                ),
                SizedBox(height: 20),
                Text('Für mehr Kontent bitte', textAlign: TextAlign.center,),
                Center(child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text('einloggen'),
                ),
                ),
                Text('oder', textAlign: TextAlign.center,),
                Center(child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text('Registrieren'),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}