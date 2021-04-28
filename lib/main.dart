import 'package:flutter/material.dart';
import 'package:home/helper/authenticate.dart';
import 'package:home/helper/helperfunction.dart';
import 'package:home/views/chatrooms.dart';
import 'package:home/views/signup.dart';


void main()=> runApp(Myapp());

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  bool userIsLoggedIn = false;
  @override
  void initState(){
     getLoggedInState();
    super.initState();
  }
 getLoggedInState() async{
   await helperFunction.getuserLoggedInSharedPreference().
   then((value){
setState(() {
  userIsLoggedIn= value;
});
   });
 }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBoxing',
      home:userIsLoggedIn ? ChatRoom() 
      :  Authenticate()
     
    );
  }
}

