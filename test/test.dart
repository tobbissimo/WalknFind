import 'package:flutter_test/flutter_test.dart';
import 'package:walkandfind/services/database.dart';

class Test {

  void main() => testRoomUpdate();

  testRoomUpdate() {
    dynamic result =
    DatabaseService(uid: 'TestUid').updateRoomData(
        'testTitle', 'TestDescription', 'TestType', '50', '400', 'Link', 'Address', 'Testcoordinates', 'Ich', 'email@email.com');
  }
}