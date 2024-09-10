import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_management/Const/color.dart';
class buttonWidget{

  Widget customButtom({
    required String? text,required VoidCallback onPressed,required Color color,
}){
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(color),
        ),
          onPressed: onPressed,
          child: Text(text!,style: TextStyle(color: Colors.white),)
      ),
    );
  }
}