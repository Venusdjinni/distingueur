import 'package:firebase_database/firebase_database.dart';
import 'persistence.dart';
class PersistenceDao {
  final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference().child('persistence');

  void saveMessage(Map data) {
    _messagesRef.push().set(data);
  }
 Query searchMessageQuery(String query){
  return  _messagesRef.orderByKey();
  }
  Query getMessageQuery() {
    return _messagesRef.orderByKey();
  }

}
