import 'package:flutter/cupertino.dart';
import 'package:personal_finance_management/Const/color.dart';
import 'package:personal_finance_management/textWidget/text.dart';

Widget CustomBox({required double heightSize,required double? widthSize,required String text,
required Color color,required double textSize,required String headText,required double headTextSize,
required IconData icon,required Color iconColor}){
  return Container(
    height:heightSize ,
    width: widthSize,
    decoration: BoxDecoration(
      color:AppColor.customWhite,
      boxShadow: [BoxShadow(
          color: const Color(0xFF000000),
        offset: Offset.zero,
        blurRadius: 1.0,
          spreadRadius: 1.0
      ),]
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: normalText(text: text,color: color,size:textSize ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            headingText(text: headText,color: color,size:headTextSize ),
            Icon(icon,size:30 ,color: iconColor,),
          ],
        )
      ],
    ),
  );
}