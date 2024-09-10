import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_management/AuthScreen/loginScreen.dart';
import 'package:personal_finance_management/AuthScreen/signupScreen.dart';
import 'package:personal_finance_management/Provider/AuthProvider/loginProvider.dart';
import 'package:personal_finance_management/Provider/AuthProvider/signUpProvider.dart';
import 'package:personal_finance_management/Provider/HomeScreenProvider/homeProvider.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyC4wKBnzgrxHpa3jLnNGuvN8BohooF_lAI",
        appId: "1:747235741097:android:e91cde782b0b5636bf88b8",
        messagingSenderId: "747235741097",
        projectId: "personal-finance-managem-a793d"
    )
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>signUpProvider()),
          ChangeNotifierProvider(create: (_)=>logProvider()),
          ChangeNotifierProvider(create: (_)=>homeProvider()),
        ],
      child: Builder(builder: (BuildContext context){
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const loginScreen(),
        );
      }),
    );


  }
}

