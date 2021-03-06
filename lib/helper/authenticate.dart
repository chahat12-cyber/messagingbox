import 'package:flutter/material.dart';
import 'package:home/views/signin.dart';
import 'package:home/views/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn= true;
  void toggle(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
   if(showSignIn){
     return SignIn(toggle);
   }else{
     return SignUp(toggle);
   }
  }
}