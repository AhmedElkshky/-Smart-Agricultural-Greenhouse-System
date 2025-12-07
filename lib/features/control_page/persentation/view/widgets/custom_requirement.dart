import 'package:flutter/material.dart';

class CustomRequirement extends StatelessWidget {
   CustomRequirement({Key? key , required this.text , this.borderColor}) : super(key: key);
String text ;
Color? borderColor ;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      height: 35,
      width: 105,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff33000000),
            blurRadius: 8,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: borderColor?? Colors.white , width: 3)
      ),
    );
  }
}
