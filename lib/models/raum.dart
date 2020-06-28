import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';

class Room {
  final String id;
  final String title;
  final String description;
  final String type;
  final String size;
  final Decimal price;
  final String foto;
  final String address;
  final String coordinates;
  final String uid;
  final Timestamp begin;
  final Timestamp end;
  final String email;
  final List<dynamic> saved;


  Room({this.id, this.title, this.description, this.type, this.size, this.price, this.foto, this.begin,
    this.uid, this.end, this.coordinates, this.address, this.email, this.saved});
}