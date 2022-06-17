import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  late final FirebaseAuth _firebaseAuth;

  AuthService._(){
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future login(String email,String password)async{
    try{
      var res = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return res;
    }on FirebaseAuthException catch (e){
      return e.message;
    }on Exception{
      return 'Error while logging in';
    }
  }

  Future signup(String email,String password)async{
    try{
      var res = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return res;
    }on FirebaseAuthException catch (e){
      return e.message;
    }on Exception{
      return 'Error while signing up';
    }
  }

}