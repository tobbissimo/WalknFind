import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';

class Event {
  final String id;
  final String title;
  final String type;
  final String description;
  final Timestamp begin;
  final Timestamp end;
  final String address;
  final String coordinates;
  final String uid;
  final String email;
  final String foto;
  final Decimal price;
  final List<dynamic> attending;

  Event({this.id, this.type, this.address, this.end, this.coordinates, this.begin, this.description,
    this.title, this.uid, this.email, this.foto, this.price, this.attending});

  void printList() {
    print(attending.length);
    attending.forEach((e) => print(e));
  }

  void printTime() {
    print(begin);
  }

}