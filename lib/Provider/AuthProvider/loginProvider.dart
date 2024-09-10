import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Bottom Navigation Bar/bottomNavBar.dart';
import '../../Const/flutterToast.dart';


class logProvider with ChangeNotifier{
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final  loginKey=GlobalKey<FormState>();
  bool _loading=false;
  bool get loading =>_loading;
  void setloading(bool value){
    _loading =value;
    notifyListeners();
  }
  Future<void> logIn(BuildContext context)async{
    if(loginKey.currentState!.validate()){
      setloading(true);
      try{
        UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text,
            password: password.text);
        setloading(false);
        var authCredential=userCredential.user!.uid;
        if(authCredential!.isNotEmpty){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const BottomNavScreen()));
        }
      }on FirebaseAuthException catch(e){
        if(e.code=='user-not-found'){
          toastMessage('No User Found!');
        }else if(e.code=='wrong-password'){
          toastMessage('Incorrect password');
        }
        setloading(false);
        print(e.toString());
        toastMessage(e.toString());
      }
    }
    setloading(false);
  }
  InputDecoration buildInputDecoration({
    required String labelText,required String hintText ,required  IconData suffixIcon}) {
    return InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: Icon(suffixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }
}