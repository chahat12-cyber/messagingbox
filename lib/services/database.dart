import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  getUser(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }
  getUserEmail(String userEmail) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  uploadInfo(userMap) {
    Firestore.instance.collection("users").add(userMap);
  }
  createChatRoomMap(String chatroomId, chatroomMap){
   Firestore.instance.collection("chatroom")
   .document(chatroomId).setData(chatroomMap).catchError((e){

   });
}

getConversionMessages(String chatRoomId)async{
  return await Firestore.instance.collection("chatroom")
  .document(chatRoomId).collection("chats")
  .orderBy("time", descending: false)
  .snapshots();
}

addConversionMessages(String chatRoomId, messageMap){
  Firestore.instance.collection("chatroom")
  .document(chatRoomId).collection("chats")
  .add(messageMap);
}

getChatRoom(String userName)async{
  return await Firestore.instance.collection("chatroom").
   where("users", arrayContains: userName)
   .snapshots();
}

}

