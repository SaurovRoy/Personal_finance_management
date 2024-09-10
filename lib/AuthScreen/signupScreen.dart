import 'package:flutter/material.dart';
import 'package:personal_finance_management/AuthScreen/loginScreen.dart';
import 'package:personal_finance_management/AuthScreen/validation.dart';
import 'package:personal_finance_management/Provider/AuthProvider/signUpProvider.dart';
import 'package:personal_finance_management/Const/color.dart';
import 'package:personal_finance_management/textWidget/buttonWidget.dart';
import 'package:personal_finance_management/textWidget/text.dart';
import 'package:provider/provider.dart';
class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}
class _signupScreenState extends State<signupScreen> {
  @override
  Widget build(BuildContext context) {
    print('build');
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
      ),
      backgroundColor: AppColor.blue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            height:size.height*1,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50),
              topRight: Radius.circular(50)),
            ),
            child:Consumer<signUpProvider>(builder: (context,value,child){
              return Column(
                children: [
                  SizedBox(height: size.height*0.15,),
                  headingText(color:Colors.black,text: 'Sign Up',size: size.width * 0.09),
                  SizedBox(height: size.height*0.05,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                        key:value.key ,
                        child:Column(
                          children: [
                            TextFormField(
                              decoration: value.buildInputDecoration(
                                  labelText: 'Email', hintText:'Enter your email', suffixIcon: Icons.email),
                              controller: value.email,
                              validator:(val) {
                                return emailValidation(val);
                              },
                            ),
                            SizedBox(height: size.height*0.03,),
                            TextFormField(
                              obscureText: true,
                              decoration: value.buildInputDecoration(
                                  labelText: 'Password', hintText:'Enter your password', suffixIcon: Icons.lock),
                              controller: value.password,
                              validator:(val) {
                                return passwordValidation(val);
                              },
                            ),
                            SizedBox(height: size.height*0.05,),
                            value.loading?CircularProgressIndicator(): buttonWidget().customButtom(
                                text:'Sign Up', onPressed:(){value.submitForm(context);}, color: AppColor.blue),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                normalText(text: 'Already have account?',color: Colors.black,size: size.width*0.05),
                                TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>loginScreen()));},
                                    child: const Text('Login'))
                              ],
                            )
                          ],
                        )
                    ),
                  ),
                ],
              );
            }
            ),
          ),
        ),
      ),
    );
  }
}
