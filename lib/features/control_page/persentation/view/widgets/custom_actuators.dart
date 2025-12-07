import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
class CustomActuators extends StatelessWidget {
   CustomActuators({Key? key, required this.text,required this.icon, required this.data}) : super(key: key);

   String text;
   IconData icon ;
   String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xff4B39EF).withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 8,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientText(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              gradientType: GradientType.linear,
              gradientDirection: GradientDirection.ltr,
              radius: 20,
              colors: [
                Color(0xff101213),
                Color(0xFF4B39EF),
              ],
            ),
            Icon(
                icon,
              color: Color(0xff39D2C0),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                child: Center(child: Text(data,style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),),
                height: 28,
                width: 80,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff33000000),
                      blurRadius: 8,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
