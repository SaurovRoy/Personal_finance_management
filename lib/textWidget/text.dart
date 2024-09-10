import 'package:flutter/cupertino.dart';

Widget normalText({
  String? text,
  Color? color,
  double? size,
}) {
  return Text(text!, style: TextStyle(
      fontFamily: "quick_semi",
      fontSize: size,
      color: color,
    ),
  );
}
Widget headingText({
  String? text,
  double? size,
  Color? color,
}){
  return Text(text.toString(),style: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: size,
    fontFamily: 'quick_bold',
      color: color,
  ),
  );
}