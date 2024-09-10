import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_management/Bottom%20Navigation%20Bar/HomeScreens/AddCategory.dart';
import 'package:personal_finance_management/Const/color.dart';
import 'package:personal_finance_management/Const/flutterToast.dart';
import 'package:personal_finance_management/Provider/HomeScreenProvider/homeProvider.dart';
import 'package:personal_finance_management/textWidget/buttonWidget.dart';
import 'package:provider/provider.dart';

import '../../Const/AppIcon.dart';
class AlertDialogScreen extends StatefulWidget {
  const AlertDialogScreen({super.key});

  @override
  State<AlertDialogScreen> createState() => _AlertDialogScreenState();
}

class _AlertDialogScreenState extends State<AlertDialogScreen> {
var catgory='Income';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<homeProvider>(builder: (context,value,child) {
        return Form(
          child: Column(
            children: [
              TextFormField(
                controller: value.amount_controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Amount'
                ),
              ),
              TextFormField(
                controller: value.descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Description'
                ),
              ),

              AddCategory(
                  categoryType: value.catgory,
                  onChanged: (val) {
                    if (value != null) {
                      value.setCatgory(val);
                    }
                  }
              ),
              DropdownButtonFormField(
                value: value.type,
                items: [
                  DropdownMenuItem(
                    child: Text('Income'),
                    value: 'Income',
                  ),
                  DropdownMenuItem(
                    child: Text('Expense'),
                    value: 'Expense',
                  ),
                ],
                onChanged: (val) {
                  if (value != null) {
                    value.setType(val);
                  }
                },
              ),
              SizedBox(height: 15,),
              buttonWidget().customButtom(
                  text: 'Add', onPressed: () {
                value.Add(context);
              }, color: AppColor.blue),
            ],
          ),
        );
      }
    ),
    );
  }
}
