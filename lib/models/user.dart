class User {
  final String uid;
  final String email;
  User({this.uid, this.email});
}

class UserData {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String tel;
  final bool mitglied;
  final List<dynamic> interests;

  UserData({this.uid, this.firstName, this.lastName, this.email, this.tel, this.mitglied, this.interests});
}