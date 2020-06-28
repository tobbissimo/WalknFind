import 'package:flutter/material.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/screens/loading.dart';
import 'package:walkandfind/screens/mitglied/new_ad.dart';
import 'package:walkandfind/screens/registered_user/equipment_list.dart';
import 'package:walkandfind/screens/registered_user/newsfeed.dart';
import 'package:walkandfind/screens/registered_user/room_list.dart';
import 'package:walkandfind/screens/registered_user/user_edit.dart';
import 'package:walkandfind/screens/user/event_list.dart';
import 'package:walkandfind/screens/user/kontakt.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/services/database.dart';
import 'package:walkandfind/shared/constants.dart';

//The Screen you get when you press the User Feed button
class RegisteredUserView extends StatefulWidget {
  @override
  _RegisteredUserViewState createState() => _RegisteredUserViewState();

}

class _RegisteredUserViewState extends State<RegisteredUserView> {
  //final AuthService _auth = AuthService();


  String _name = '';
  String _nachname = '';
  String _equipment = '1 Mikro und 2 Boxen';
  String _event = 'Gewerkschaft';
  String _immo = 'Atelier 20m²';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return  StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          _name = userData?.firstName ?? '';
          _nachname = userData?.lastName ?? '';
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('Benutzer Bereich'),
//              actions: <Widget>[
//                IconButton(
//                  padding: EdgeInsets.only(right: 6),
//                  onPressed: () {},
//                  icon: Icon(Icons.person_outline,
//                    size: 50.0,
//                  ),
//                ),
//                PopupMenuButton(
//                  itemBuilder: (BuildContext context) {
//                    //TODO: items in popupmenu in main programieren
//                  },
//                )
//              ],
            ),
            body:
            ListView(
              children: <Widget>[
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    title: Text('Deine projekte'),
                    contentPadding: EdgeInsets.only(left: 20),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.category),
                  title: Text('Mein Equipment'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentList(equipment: 'meine',)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text('Meine Events'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EventList(events: 'meine',)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Meine Räume'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RoomList(rooms: 'meine')));
                  },
                ),
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    title: Text('Aktuelles'),
                    contentPadding: EdgeInsets.only(left: 20),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.category),
                  title: Text('Gespeicherte Events'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EventList(events: 'saved',)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text('Gespeicherte Equipment'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentList(equipment: 'saved')));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Gespeicherte Räume'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RoomList(rooms: 'saved')));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Location für events 300m²'),
                  onTap: () {
                    return print('immo gedrückt');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.category),
                  title: Text('Mischpult 25 Channels'),
                  onTap: () {
                    return print('equipment gedrückt');
                  },
                ),
              ],
            ),
            drawer: Card(
              elevation: 20,
              borderOnForeground: true,
              margin: EdgeInsets.only(right: 100),
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: background,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSu116m2Yin_pDnk3vz0zR4f8ZL4mftaaILlWDIDl8raX9gEyJP'),
                        ),
                        SizedBox(width: 12,),
                        Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.red[700],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(_name,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(_nachname,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(onPressed: () {},
                    padding: EdgeInsets.only(left: 0),
                    child: ListTile(
                      leading: Icon(Icons.add_location, size: 40,),
                      title: Text('Neues Projekt erstellen'),
                      subtitle: Text(''),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewAd()));
                      },
                    ),
                  ),
                  FlatButton(onPressed: () {},
                    padding: EdgeInsets.only(left: 0),
                    child: ListTile(
                      leading: Icon(Icons.save_alt, size: 40,),
                      title: Text('Gespeicherte Projekte'),
                      subtitle: Text('2 gespeicherte Projekte'),
                    ),
                  ),
                  FlatButton(onPressed: () {},
                    padding: EdgeInsets.only(left: 0),
                    child: ListTile(
                      leading: Icon(Icons.email, size: 40,),
                      title: Text('Nachrichten'),
                      subtitle: Text('keine neue Nachrichten'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsFeed()));
                      },
                    ),
                  ),
                  FlatButton(onPressed: () {},
                    padding: EdgeInsets.only(left: 0),
                    child: ListTile(
                      leading: Icon(Icons.build, size: 40,),
                      title: Text('Feed-Filter Einstellungen'),
                      subtitle: Text('noch nicht personalisiert'),

                    ),
                  ),
                  FlatButton(onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserEdit()));
                  },
                    padding: EdgeInsets.only(left: 0),
                    child: ListTile(
                      leading: Icon(Icons.person_pin, size: 40,),
                      title: Text('Profil bearbeiten'),
                      subtitle: Text('Daten ändern/Konto löschen'),
                    ),
                  ),
                  FlatButton(onPressed: () {},
                    padding: EdgeInsets.only(left: 0),
                    child: ListTile(
                      leading: Icon(Icons.info, size: 40,),
                      title: Text('Kontakt zu und Info über das Verein'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Kontakt()));
                      },
                    ),
                  ),

                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}
