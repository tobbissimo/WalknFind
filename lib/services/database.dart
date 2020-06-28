import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:walkandfind/models/equipment.dart';
import 'package:walkandfind/models/raum.dart';
import 'package:walkandfind/models/user.dart';
import 'package:walkandfind/models/event.dart';

//This class takes care of all the Database relevant stuff.
//TODO Change update equipment and room data to accept document ids for editing
class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Collection references
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference eventCollection = Firestore.instance.collection('events');
  final CollectionReference roomCollection = Firestore.instance.collection('rooms');
  final CollectionReference equipmentCollection = Firestore.instance.collection('equipment');

  Future updateUserData(String firstName, String lastName, String email,
      String tel, bool mitglied) async {
    try {
      await userCollection.document(uid).setData({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'tel': tel,
        'mitglied': mitglied
      });
      return true;
    } catch (e) {
      print('I am in catch');
      return false;
    }

  }

  Future<bool> updateEventData(String title, String type, String description, DateTime begin, DateTime end,
      String address, String coordinates, String email, String preis, String foto, String id) async {
    var val = [uid];
    try {
      await eventCollection.document(id).setData({
        'title': title,
        'type': type,
        'description': description,
        'begin': begin,
        'end': end,
        'address': address,
        'coordinates': coordinates,
        'uid': uid,
        'email': email,
        'price': preis,
        'foto': foto,
        'attending': FieldValue.arrayUnion(val)
      });
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  Future updateRoomData(String id, String title, String description, String type, String size, String price, String foto,
      String address, String coordinates, String email, DateTime begin, DateTime end) async {
    bool success = true;
    var val = [uid];
    try {
      await roomCollection.document(id).setData({
        'title': title,
        'description': description,
        'type': type,
        'size': size,
        'price': price,
        'foto': 'https://medicitv-b.imgix.net/movie/zaryadye-concert-hall-grand-opening_d_iDyUWrY.jpg?auto=format&q=85',
        'address': address,
        'coordinates': coordinates,
        'uid': uid,
        'email': email,
        'begin': begin,
        'end': end,
        'available': true,
        'saved': FieldValue.arrayUnion(val)
      });
    } catch(e) {
      print(e.toString());
      success = false;
    }
    return success;
  }

  Future updateEquipmentData(String title, String description, String price, String address,
      String coordinates, String foto, DateTime begin, DateTime end, String type, String email, bool available, String id
      ) async {
    var val = [uid];
    try {
      await equipmentCollection.document(id).setData({
        'title': title,
        'description': description,
        'price': price,
        'address': address,
        'coordinates': coordinates,
        'foto': 'https://medicitv-b.imgix.net/movie/zaryadye-concert-hall-grand-opening_d_iDyUWrY.jpg?auto=format&q=85',
        'uid': uid,
        'begin': begin,
        'end': end,
        'type': type,
        'email': email,
        'available': available,
        'saved': FieldValue.arrayUnion(val)
      });
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  //event list from snapshot
  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Event(
        id: doc.documentID ?? '',
        title: doc.data['title'] ?? '',
        type: doc.data['type'] ?? '',
        description: doc.data['description'] ?? '',
        begin: doc.data['begin'],
        end: doc.data['end'] ?? '',
        address: doc.data['address'] ?? '',
        coordinates: doc.data['coordinates'] ?? '',
        uid: doc.data['uid'] ?? '',
        email: doc.data['email'] ?? '',
        foto: doc.data['foto'] ?? '',
        price: Decimal.parse(doc.data['price']) ?? Decimal.zero,
        attending: List.from(doc.data['attending'] ?? List())
      );
    }).toList();
  }

  //raum list from snapshot
  List<Room> _roomListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Room(
          id: doc.documentID,
          title: doc.data['title'] ?? '',
          description : doc.data['description'] ?? '',
          type: doc.data['type'] ?? '',
          size: doc.data['size'] ?? '0',
          price: Decimal.parse(doc.data['price']) ?? Decimal.zero,
          foto: doc.data['foto'] ?? '',
          address: doc.data['address'] ?? '',
          coordinates: doc.data['coordinates'] ?? '',
          uid: doc.data['uid'] ?? '',
          begin: doc.data['begin'],
          end: doc.data['end'],
          email: doc.data['email'],
          saved: List.from(doc.data['saved'] ?? List())
      );
    }).toList();
  }

  List<Equipment> _equipmentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Equipment(
          id: doc.documentID,
          title: doc.data['title'] ?? '',
          description : doc.data['description'] ?? '',
          price: Decimal.parse(doc.data['price']) ?? Decimal.zero,
          address: doc.data['address'] ?? '0',
          coordinates: doc.data['coordinates'] ?? '',
          foto: doc.data['foto'] ?? '',
          uid: doc.data['uid'] ?? '',
          begin: doc.data['begin'] ?? '',
          end: doc.data['end'] ?? '',
          email: doc.data['email'] ?? '',
          type: doc.data['type'] ?? '',
          saved: List.from(doc.data['saved'] ?? List())
      );
    }).toList();
  }
  
  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        firstName: snapshot.data['firstName'] ?? '',
        lastName: snapshot.data['lastName'] ?? '',
        email: snapshot.data['email'] ?? '',
        tel: snapshot.data['tel'] ?? '',
        mitglied: snapshot.data['mitglied']  ?? false,
        interests: List.from(snapshot.data['interests'] ?? List())
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  Stream<List<Event>> get events {
    try{
      return eventCollection.where("begin", isGreaterThanOrEqualTo: DateTime.now()).snapshots()
        .map(_eventListFromSnapshot);
    } catch(e) {
        print(e.toString());
      return null;
    }
  }

  //get raum stream
  Stream<List<Room>> get rooms {
    return roomCollection.snapshots()
        .map(_roomListFromSnapshot);
  }

  //get equipment stream
  Stream<List<Equipment>> get equipment {
    return equipmentCollection.where("available", isEqualTo: true).snapshots()
        .map(_equipmentListFromSnapshot);
  }

  Stream<List<Event>> get mySavedEvents {
    try{
      return eventCollection.where("attending", arrayContains: uid)
          .where("begin", isGreaterThanOrEqualTo: DateTime.now()).snapshots().map(_eventListFromSnapshot);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<Equipment>> get mySavedEquipment {
      return equipmentCollection.where("saved", arrayContains: uid).where("available", isEqualTo: true).snapshots().map(_equipmentListFromSnapshot);
  }

  Stream<List<Room>> get mySavedRooms {
    return roomCollection.where("saved", arrayContains: uid).where("available", isEqualTo: true).snapshots().map(_roomListFromSnapshot);
  }

  Stream<List<Event>> get myEvents {
    try{
      return eventCollection.where("uid", isEqualTo: uid).orderBy('begin').snapshots().map(_eventListFromSnapshot);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<Equipment>> get myEquipment {
    try{
      return equipmentCollection.where("uid", isEqualTo: uid).snapshots().map(_equipmentListFromSnapshot);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<Room>> get myRooms {
    try{
      return roomCollection.where("uid", isEqualTo: uid).snapshots().map(_roomListFromSnapshot);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future updateSavedEvents(String eventId) async {
    var val = [uid];
    return await eventCollection.document(eventId).updateData({"attending": FieldValue.arrayUnion(val)});
  }

  Future removeSavedEvents(String eventId) async {
    var val = [uid];
    return await eventCollection.document(eventId).updateData({"attending":FieldValue.arrayRemove(val) });
  }

  Future updateSavedEquipment(String equipmentId) async {
    var val = [uid];
    return await equipmentCollection.document(equipmentId).updateData({"saved": FieldValue.arrayUnion(val)});
  }

  Future removeSavedEquipment(String equipmentId) async {
    var val = [uid];
    return await eventCollection.document(equipmentId).updateData({"saved":FieldValue.arrayRemove(val) });
  }

  Future updateSavedRooms(String roomId) async {
    var val = [uid];
    return await equipmentCollection.document(roomId).updateData({"saved": FieldValue.arrayUnion(val)});
  }

  Future removeSavedRooms(String roomId) async {
    var val = [uid];
    return await roomCollection.document(roomId).updateData({"saved":FieldValue.arrayRemove(val) });
  }

  Future deleteEvent(String eventId) async {
    return await eventCollection.document(eventId).delete();
  }

  Future deleteEquipment(String equipmentId) async {
    return await equipmentCollection.document(equipmentId).delete();
  }

  Future deleteRoom(String roomId) async {
    return await roomCollection.document(roomId).delete();
  }
}