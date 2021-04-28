import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home/helper/helperfunction.dart';
import 'package:home/services/auth.dart';
import 'package:home/services/database.dart';
import 'package:home/views/chatrooms.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey= GlobalKey<FormState>();
  AuthMethod authMethod= new AuthMethod();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
   bool isLoading= false;
   DataBaseMethods dataBaseMethods= new DataBaseMethods();
   QuerySnapshot snapshotUserInfo;
   signIn(){
     if(formkey.currentState.validate()){
       helperFunction.saveUserEmailSharedPreference(email.text);
        // helperFunction.saveUserNameSharedPreference(username.text);
      dataBaseMethods.getUserEmail(email.text)
        .then((value){
snapshotUserInfo= value;
helperFunction.saveUserNameSharedPreference
(snapshotUserInfo.documents[0].data["name"]);
        });
        
       setState(() {
         isLoading= true;
       });
        
       authMethod.signInWithEmailAndPassword(email.text, 
       password.text).then((value){
         if(value!= null){
          
           helperFunction.saveuserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()
            ));
         }
       });
      }
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
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Form(
          key: formkey,
                      child: Column(
              children: [
                TextFormField(
                  validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val)
                                ? null
                                : "please provide a valid email id";
                          },
                  controller: email,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: 'email',
                      hintStyle: TextStyle(
                        color: Colors.white24,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            validator: (val) {
                            return val.length > 6
                                ? null
                                : "please provide pass word greater than 6 characters";
                          },
            controller: password,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'password',
              hintStyle: TextStyle(
                color: Colors.white24,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerRight,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: (){
              signIn();
            },
                      child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 28),
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.blue[700]]),
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Sign In",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 28),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Text(
              "Sign In with Google",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
          SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: (){
                widget.toggle();
              },
              child:
              Container(
                padding: EdgeInsets.symmetric(vertical:8),
                child: Text(
                "Register Now",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    decoration: TextDecoration.underline),
            ),
              )
            )
          ])
        ]),
      ),
    );
  }
}
