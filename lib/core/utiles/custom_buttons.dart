import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function()? onPressed;
  Widget text;
  Color color;
  Color? borderColor;
  double width;
  double height;
  double radius ;
  Color? shadowColor;
  double? elevation;
  CustomButton({
    Key? key,
    this.onPressed,
    required this.text,
    required this.color,
    this.borderColor,
    required this.width,
    required this.height,
    required this.radius,
    this.shadowColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: shadowColor,
        elevation: elevation,
        side: BorderSide(
          color: borderColor ?? Colors.white,
        ),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        minimumSize: Size(width, height),
      ),
      onPressed: onPressed,
      child: text,

    );
  }
}
