import 'package:flutter/material.dart';
import 'package:home/helper/authenticate.dart';
import 'package:home/helper/helperfunction.dart';
import 'package:home/services/auth.dart';
import 'package:home/services/database.dart';
import 'package:home/views/chatrooms.dart';
import 'package:home/views/signin.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMethod authMethod = new AuthMethod();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  signMeUp() {
    if (formkey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": username.text,
        "email": email.text,
      };
         helperFunction.saveUserEmailSharedPreference(email.text);
         helperFunction.saveUserNameSharedPreference(username.text);
      setState(() {
        isLoading = true;
      });
      authMethod
          .signupWithEmailAndPassword(email.text, password.text)
          .then((value) {
        dataBaseMethods.uploadInfo(userInfoMap);
           helperFunction.saveuserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
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
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            return val.isEmpty || val.length < 2
                                ? "This is empty"
                                : null;
                          },
                          controller: username,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'username',
                              hintStyle: TextStyle(
                                color: Colors.white24,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                        ),
                        SizedBox(height: 10),
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
                        SizedBox(height: 10),
                        TextFormField(
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
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      signMeUp();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 28),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.blue[700]]),
                          borderRadius: BorderRadius.circular(30)),
                      child: GestureDetector(
                        onTap: () {
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 28),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Sign In with Google",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          widget.toggle;
                        },
                        child: Text(
                          "SignIn!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
