import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yuchat/services/shared_pref.dart';

class DatabaseMethods {
  Future addUserdetail(Map<String, dynamic> userinfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userinfo);
  }

  Future<QuerySnapshot> getuserdata(String mail) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("Mail", isEqualTo: mail)
        .get();
  }

  createchatroom(String chatroomid, Map<String, dynamic> chatroominfo) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomid)
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatroomid)
          .set(chatroominfo);
    }
  }

  Future addmessage(String chatroomid, String messageid,
      Map<String, dynamic> messageinfmap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomid)
        .collection("chats")
        .doc(messageid)
        .set(messageinfmap);
  }

  updatelastmessagesend(
      String chatroomid, Map<String, dynamic> lastmessageinfomap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomid)
        .update(lastmessageinfomap);
  }

  Future<Stream<QuerySnapshot>> getchatroommessage(chatroomid) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomid)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getuserbyusername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }

  Future<Stream<QuerySnapshot>> getchatrooms() async {
    String? myusername = await SharedprefHelper().getuser_username();
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .orderBy("time", descending: true)
        .where("users", arrayContains: myusername!.toUpperCase())
        .snapshots();
  }


  // import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkIfIdExists(String id) async {
  try {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users') // Replace 'users' with your collection name
        .doc(id)
        .get();

    return doc.exists; // Returns true if the document exists, false otherwise
  } catch (e) {
    print('Error checking ID: $e');
    return false;
  }
}

}
