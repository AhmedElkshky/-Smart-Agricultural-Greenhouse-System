import 'package:flutter/material.dart';

class CustomListTileControl extends StatelessWidget {
   CustomListTileControl({Key? key,
   required this.title,
   required this.subTitle,
   required this.icon,}) : super(key: key);
String title;
String subTitle;
IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff2A5773),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          icon,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
    ;
  }
}
