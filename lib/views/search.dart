import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home/helper/constants.dart';
import 'package:home/helper/helperfunction.dart';
import 'package:home/services/database.dart';
import 'package:home/views/conversationscreen.dart';

class SearchScreen extends StatefulWidget {


  @override
  _SearchScreenState createState() => _SearchScreenState();
}
  String _myName; 
class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = new TextEditingController();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  QuerySnapshot searchshot;
  
  Widget searchList() {
    return searchshot != null
        ? ListView.builder(
            itemCount: searchshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchshot.documents[index].data["name"],
                useremail: searchshot.documents[index].data["email"],
              );
            },
          )
        : Container();
  }

  initiateSearch() {
    dataBaseMethods.getUser(search.text).then((val) {
      setState(() {
        searchshot = val;
      });
    });
  }

  createChatRoom(String userName) {
    print("${Constants.myName}");

    if (userName == Constants.myName) {
      String chatroomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatroomId,
      };
      DataBaseMethods().createChatRoomMap(chatroomId, chatRoomMap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Conversationscreen(
            chatroomId
          )));
    }else{
      print("you cannot send message to yourself");
    }
  }

  Widget SearchTile({String userName, String useremail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
        Column(
          children: [
            Text(
              userName,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              useremail,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            createChatRoom(userName);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              "Message",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
  @override
  void initState() {
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
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: search,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'search username',
                    hintStyle: TextStyle(
                      color: Colors.white24,
                    ),
                    border: InputBorder.none,
                  ),
                )),
                GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          searchList()
        ],
      )),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
