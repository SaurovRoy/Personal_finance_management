import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Const/flutterToast.dart';

class homeProvider with ChangeNotifier{
  var _type='Income';
  var _catgroy='';
  get type=>_type;
  get catgory=>_catgroy;
  void setType(var value){
    _type=value;
    notifyListeners();
  }
  void setCatgory(var value){
    _catgroy=value;
    notifyListeners();
  }
  String id=DateTime.now().millisecond.toString();
  int timeStamp=DateTime.now().microsecondsSinceEpoch;
  DateTime date = DateTime.now();
  int selectedIconCodePoint = 0;
  TextEditingController amount_controller=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  Add(BuildContext context)async{
    final firebaseStore=await FirebaseFirestore.instance.collection('finance_management');
    firebaseStore.doc(id).set({
      'amount':int.parse(amount_controller.text),
      'description':descriptionController.text,
      'type':type,
      'category':catgory,
      'icon':selectedIconCodePoint,
      'id':id,
      'time':timeStamp,
      'date':Timestamp.fromDate(date),
    }).then((value){
      toastMessage('Added Successfully');
      Navigator.pop(context);
    }).onError((e,stackTrace){
      toastMessage(e.toString());
    });
  }
}