import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> logIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> activeUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  Future<String> logIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if(user.isEmailVerified) {
      return user.uid;
    }
    else {
      return null;
    }
    
  }

  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    user.sendEmailVerification();
    print("Verification mail sent.");
    return user.uid;
  }

  Future<String> activeUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

}