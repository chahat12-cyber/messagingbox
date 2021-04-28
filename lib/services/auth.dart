import 'package:firebase_auth/firebase_auth.dart';
import 'package:home/module/user.dart';
class AuthMethod{
final FirebaseAuth _auth= FirebaseAuth.instance;
User _userfromfirebaseUser(FirebaseUser user){
  return user!= null ? User(userId: user.uid):null;
}
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
       AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       FirebaseUser firebaseUser = result.user;
          return _userfromfirebaseUser(firebaseUser);
    }catch(e){
          print(e);
    }

}
  Future  signupWithEmailAndPassword(String email, String password)async{
     try{
     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       FirebaseUser firebaseUser= result.user;
       return _userfromfirebaseUser(firebaseUser);
     }catch(e){
       print(e);
     }

  Future resetPass(String email)async{
       try{
         return await _auth.sendPasswordResetEmail(email: email);
       }catch(e){
         print(e.toString());
       }
     }
   }
  Future signOut()async{
          try{
            return await  _auth.signOut();
          }catch(e){
            print(e);
          }
        }

}