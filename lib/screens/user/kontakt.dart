import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Kontakt extends StatelessWidget {

  _launchURL(String url) async {
    //
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Karte_rot.png'),
                    fit: BoxFit.cover
                )
            ),
            child: Center(
                child: Container(
                    margin: EdgeInsets.fromLTRB(40, 60, 40, 35),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(Radius.circular(20.0),
                        )
                    ),
                    child: ListView(
                        shrinkWrap: true,
                        padding:  const EdgeInsets.all(20.0),
                        children: <Widget>[
                          Text('BOEM* – Association for Art, Culture, Science and Communication',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),),
                          SizedBox(height: 20,),
                          Text('ZVR-Zahl: 935515560\nAdresse:\nKoppstraße 26/1-5\n1160 Wien, Austria'),
                          SizedBox(height: 20,),
                          Text('Im Prinzip – versuchen wir Ökonomie, Kunst und Aktivismus zu verbinden. Auf zu einer kreativen Selbstorganisation. Kunst ist für uns nichts das vom Können kommt. Vom Können kommt Exzellenz. Exzellente Handarbeit, Kopfarbeit, Können soll im Verhältnis zu Arbeit gesehen werden. Kunst darf auch scheitern, mutig sein, Position beziehen. Kunst darf Laut sein, murmeln, deutlich sprechen und auch nuscheln. Für eine Kunst, einen Aktivismus, Aktionismus der Arbeit zu einem gesellschaftlichen Phänomen edeln möchte, und ausserhalb der eigenen bürgerlichen Klasse – partizipierend rezipiert werden soll.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(onPressed: (){
                                _launchURL('https://boem.postism.org/missionstatement/');
                              },
                                child: Text('Mehr über uns'),),
                              FlatButton(onPressed: (){
                                _launchURL('boem@postism.org');
                              },
                                child: Text('Schreib uns eine Mail'),),
                            ],
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}
