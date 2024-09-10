import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_management/AuthScreen/loginScreen.dart';
import 'package:personal_finance_management/Const/flutterToast.dart';

class signUpProvider with ChangeNotifier{
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final GlobalKey<FormState> key=GlobalKey<FormState>();
  bool _loading=false;
  bool get loading =>_loading;
  void setloading(bool value){
    _loading =value;
    notifyListeners();
  }
  Future<void> submitForm(BuildContext context)async{
    if(key.currentState!.validate()){
      setloading(true);
      try{
      UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text);
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'email': email.text,
        'password': password.text,
        'starting_balance':0,
        'starting_income':0,
        'starting_expense':0

      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up Successful')),
      );
      var authCredential=userCredential.user!.uid;
      if(authCredential!.isNotEmpty){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>loginScreen()));
      }
      await Future.delayed(Duration(seconds: 2));

      setloading(false);
      print(loading);

    }on FirebaseAuthException catch(e){
        if(e.code=='weak-password'){
          toastMessage('The password is weak');
        }else if(e.code=='email-already-in-use'){
         toastMessage('This email has already taken');
        }
      }

      }
    return setloading(false);
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