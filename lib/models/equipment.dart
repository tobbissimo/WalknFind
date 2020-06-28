import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';

class Equipment {
  final String id;
  final String title;
  final String description;
  final Decimal price;
  final String address;
  final String coordinates;
  final String foto;
  final String uid;
  final Timestamp begin;
  final Timestamp end;
  final String email;
  final String type;
  final List<dynamic> saved;

  Equipment(
      {this.id, this.title, this.description, this.address, this.price, this.coordinates, this.foto,
      this.email, this.begin, this.uid, this.end, this.type, this.saved});
}