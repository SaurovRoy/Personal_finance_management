import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_finance_management/Bottom%20Navigation%20Bar/ChartScreen/piChart.dart';
import 'package:personal_finance_management/Const/color.dart';
import '../../textWidget/customBox.dart';
import '../../textWidget/text.dart';
import '../bottomNavBar.dart';
import 'dialogScreen.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print('build');
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('finance_management').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              var snap = snapshot.data!.docs;
              double totalIncome = 0;
              double totalExpense = 0;
              double totalBalance = 0;

              for (int i = 0; i < snap.length; i++) { // Fixed loop condition
                var amount = (snap[i]['amount'] as num).toDouble();
                if (snap[i]['type'] == 'Income') {
                  totalIncome += amount;
                }
                if(snap[i]['type']=='Expense') {
                  totalExpense += amount;
                }
                totalBalance=totalIncome-totalExpense;
                FirebaseFirestore.instance.collection('finance_management').doc(FirebaseAuth.instance.currentUser!.uid).collection('total').
                doc(snap[i]['id']).set({
                  'totalIncome':totalIncome,
                  'totalExpense':totalExpense,
                  'totalBalance':totalBalance,
                });
              }


              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColor.blue),
                    child: Padding(
                      padding: EdgeInsets.only(left: size.width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingText(
                            color: Colors.white,
                            text: 'Total Balance',
                            size: size.width * 0.07,
                          ),
                          headingText(
                            color: Colors.white,
                            text: '= ${totalBalance}',
                            size: size.width * 0.1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      CustomBox(
                        heightSize: size.height * 0.13,
                        widthSize: size.width * 0.5,
                        text: 'Income',
                        color: AppColor.green,
                        textSize: size.width * 0.05,
                        headText: ' = ${totalIncome}',
                        headTextSize: size.width * 0.09,
                        icon: Icons.arrow_upward,
                        iconColor: AppColor.green,
                      ),
                      SizedBox(height: 5),
                      CustomBox(
                        heightSize: size.height * 0.13,
                        widthSize: size.width * 0.5,
                        text: 'Expense',
                        color: AppColor.red,
                        textSize: size.width * 0.05,
                        headText: ' = ${totalExpense} ',
                        headTextSize: size.width * 0.09,
                        icon: Icons.arrow_downward,
                        iconColor: AppColor.red,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: headingText(
                      text: ' Recent activities',
                      size: size.width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          color: snap[index]['type']=='Income'?Colors.green.withOpacity(0.3):
                          Colors.red.withOpacity(0.1),
                          child:ListTile(
                            minVerticalPadding: 4,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            title: Text(snap[index]['type'].toString()),
                            subtitle: Text(snap[index]['description'].toString()),
                            leading: snap[index]['type']=='Income'?Icon(Icons.monetization_on_rounded):
                            Icon(Icons.money_off_sharp),
                            trailing: Text(snap[index]['amount'].toString()),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.blue,
        onPressed: () {
          dialogBuilder(context);
        },
        child: Icon(Icons.add, color: AppColor.customWhite),
      ),
    );
  }

  dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: AlertDialogScreen(),
        );
      },
    );
  }
}
