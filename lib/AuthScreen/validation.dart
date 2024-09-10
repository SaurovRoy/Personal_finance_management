import 'package:flutter/material.dart';

String? emailValidation(String? value){
  var regex=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if(value!.isEmpty){
    return 'Pleas enter an email';
  }
  else if(!regex.hasMatch(value)){
    return 'please enter a valid email';
  }
  return null;
}

String? passwordValidation(String? value){
  if(value==null||value!.isEmpty){
    return 'password can not be null';
  }
  else if(value.length<6){
    return 'write at least six character';
  }
  return null;
}

