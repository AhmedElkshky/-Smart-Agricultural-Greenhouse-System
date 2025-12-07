import 'package:flutter/material.dart';

class CustomComponent extends StatelessWidget {
  CustomComponent({
    Key? key,
    required this.icon,
    required this.text,
    required this.data,
  }) : super(key: key);

  final String text;
  final String data;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: 116,
        width: 116,
        decoration: BoxDecoration(
          color: Color(0xffF1F4F8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Color(0xff57636C),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              child: Center(child: Text(data),),
              height: 35,
              width: 90,
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
            )
          ],
        ),
      ),
    );
  }
}
