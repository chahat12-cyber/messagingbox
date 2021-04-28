import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:home/helper/authenticate.dart';
import 'package:home/helper/constants.dart';
import 'package:home/helper/helperfunction.dart';
import 'package:home/services/auth.dart';
import 'package:home/services/database.dart';
import 'package:home/views/conversationscreen.dart';
import 'package:home/views/search.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethod authMethod = new AuthMethod();
  DataBaseMethods dataBaseMethods= new DataBaseMethods();
  Stream ChatRoomStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: ChatRoomStream,
      builder:(context, snapshot){
         return  snapshot.hasData? ListView.builder(
           itemCount: snapshot.data.documents.length,
           itemBuilder:(context, index){
             return ChatRoomsTile(
               snapshot.data.documents[index].data["chatroomId"]
               .toString().replaceAll("_", "")
               .replaceAll(Constants.myName, ""),
               snapshot.data.documents[index].
               data["chatroomId"]

             );
           }
           ):Container();
      }
       );
  }


  @override
  void initState() {
    getUserInfo( );
    super.initState();
  }
 getUserInfo()async{
   Constants.myName= await helperFunction.getUserNameSharedPreference();
    dataBaseMethods.getChatRoom(Constants.myName).
    then((value){
      setState(() {
        ChatRoomStream= value;
      });
    });
    setState(() {
      
    });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:Text("Chat Room",
        style: TextStyle(
          fontFamily: "DancingScript"
        ),),
        actions: [
          GestureDetector(
          onTap:(){
            authMethod.signOut(); 
            Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (context)=> Authenticate())
            );
          } ,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:16),
            child: Icon(Icons.logout)
            ),
        )
          
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen())
             );
      },
    child: Icon(Icons.search),),
    body: chatRoomList(),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
ChatRoomsTile(this.userName, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)=>Conversationscreen(chatRoomId))
        );
      },
          child: Container(
            color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
        child:Row(children: [
          Container(
            height: 40, 
            width: 40,
            alignment: Alignment.center,
             decoration: BoxDecoration(
               color: Colors.blue,
               borderRadius: BorderRadius.circular(40)),
            child: Text("${userName.substring(0).toUpperCase()}")
          ),
          SizedBox(width: 8),
          Text(userName,
          style: TextStyle(
            color:Colors.white
          ),)
        ],)
      ),
    );
  }
}