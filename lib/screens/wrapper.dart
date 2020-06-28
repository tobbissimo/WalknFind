import 'package:flutter/material.dart';
import 'package:walkandfind/models/user.dart';
import 'package:provider/provider.dart';
import 'package:walkandfind/screens/registered_user/registered_user_home.dart';
import 'package:walkandfind/screens/user/user_home.dart';

//This is the root widget. It receives a Stream and if that Stream contains a user it displays the registered user home screen
//if there is no user in the stream then it switches to the not logged in user home screen
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return UserHome();
    } else {
      return RegisteredUserHome();
    }

  }
}