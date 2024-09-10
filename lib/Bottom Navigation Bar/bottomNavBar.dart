import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_finance_management/AuthScreen/loginScreen.dart';
import 'package:personal_finance_management/Const/color.dart';

import '../Const/flutterToast.dart';
import 'ChartScreen/piChart.dart';
import 'HomeScreens/homeScreen.dart';
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    const homeScreen(),
     PiChartScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Future<void> LogOut()async{
    await FirebaseAuth.instance.signOut().then((value){
      toastMessage('Log out Successful');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>loginScreen()));
    }).onError((error, stackTrace) {
      toastMessage(error.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: const Text('Finance management',style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: (){LogOut();},
            icon: Icon(Icons.logout_outlined),color: AppColor.customWhite,)],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:FaIcon(FontAwesomeIcons.chartPie) ,
            label: 'Chart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.blue,
        onTap:onItemTapped,
      ),
    );
  }
}
