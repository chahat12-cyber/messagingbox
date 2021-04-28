import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:home/helper/constants.dart';
import 'package:home/services/database.dart';
class Conversationscreen extends StatefulWidget {
  final String chatRoomId;
  Conversationscreen(this.chatRoomId);

  @override
  _ConversationscreenState createState() => _ConversationscreenState();
}

class _ConversationscreenState extends State<Conversationscreen> {
   DataBaseMethods dataBaseMethods= new DataBaseMethods();
   TextEditingController messagecontroller = new TextEditingController();
   
   Stream chatMessagesStream;
   
   Widget chatMessageList(){
     return StreamBuilder(
       stream:chatMessagesStream,
       builder: (context,snapshot){
         return snapshot.hasData ? ListView.builder(
           itemCount:snapshot.data.documents.length,
           itemBuilder:(context, index){
             return MessageTile(
               snapshot.data.documents[index].data["message"],
               snapshot.data.documents[index].data["sendby"]== Constants.myName
             );
           }
           ):Container();
       },
     );
   }

   sendMessage(){
     if(messagecontroller.text.isNotEmpty){
       Map<String,dynamic> messageMap={
       "message":  messagecontroller.text,
       "sendby": Constants.myName,
       "time": DateTime.now().millisecondsSinceEpoch
            };
    dataBaseMethods.addConversionMessages(widget.chatRoomId,messageMap);
       messagecontroller.text ="";
     }
     }
     @override
  void initState() {
    dataBaseMethods.getConversionMessages(widget.chatRoomId)
    .then((value){
       chatMessagesStream= value;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text(
        'Pebbo',
        style: TextStyle(fontFamily: 'DancingScript', fontSize: 35),
      )),
      body: Container(
          child: Stack(
        children: [
          chatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller:messagecontroller ,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Message...',
                      hintStyle: TextStyle(
                        color: Colors.white24,
                      ),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                      ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
 
 class MessageTile extends StatelessWidget {
   final String message;
   final bool isSendByMe;
   MessageTile(this.message, this.isSendByMe);
   @override
   Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.only(left: isSendByMe ? 0:24 , right: isSendByMe? 24:0),
       margin: EdgeInsets.symmetric(vertical:8),
       width: MediaQuery.of(context).size.width,
       alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isSendByMe? [
                         Colors.blue,
                         Colors.blue[400],
                  ]:
                  [
                     Colors.black,
                     Colors.black45
                     
                  ]
                ),
                borderRadius:isSendByMe? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23) 
                ):BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23),
              ),
              ),
           child:Text(message, 
           
           style: TextStyle(
             color:Colors.white,
             fontSize: 17
           ),
           ),
       ),
     );
   }
 }