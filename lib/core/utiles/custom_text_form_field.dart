import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.filled,
    this.enabledOutBorder,
    this.enabledAndFocusedBorder,
    this.obscureText,
    this.height,
    this.width,
    this.fillColor,
    this.maxLine,
    this.outLineRadius,
    this.topRightRadius,
    this.bottomRightRadius,
    this.hintStyle,
    this.controller,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
  }) : super(key: key);

  Widget? prefixIcon;
  Widget? suffixIcon;
  String? labelText;
  String? hintText;
  bool? filled;
  bool? enabledOutBorder;
  InputBorder? enabledAndFocusedBorder;
  bool? obscureText;
  double? height;
  double? width;
  Color? fillColor;
  int? maxLine;
  double? outLineRadius;
  double? topRightRadius;
  double? bottomRightRadius;
  TextStyle? hintStyle;
  Function(String?)? onSaved;
  TextEditingController? controller;
  String? Function(String?)? validator ;
  void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: (enabledOutBorder == false || enabledOutBorder == null)
            ? Radius.circular(topRightRadius!)
            : Radius.circular(0),
        bottomRight: (enabledOutBorder == false || enabledOutBorder == null)
            ? Radius.circular(bottomRightRadius!)
            : Radius.circular(0),
      ),
      child: TextFormField(
        onFieldSubmitted:onFieldSubmitted ,
        onSaved:onSaved,
        validator: validator,
        controller: controller,
        obscureText: (obscureText == null) ? false : obscureText!,
        maxLines: maxLine ?? 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical:
              (height == null || height! <= 48) ? 0 : (height! - 48) * 2),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: (enabledOutBorder == true)
              ? OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(outLineRadius ?? 0)))
              : UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBEC0E),
              width: 5,
            ),
          ),
          focusedBorder: (enabledOutBorder == true)
              ? OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(outLineRadius ?? 0)))
              : UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBEC0E),
              width: 5,
            ),
          ),
          filled: filled,
          fillColor: fillColor,
          labelText: labelText,
          hintStyle: (hintStyle == null)
              ? TextStyle(
            fontFamily: 'Outfit',
            letterSpacing: 3,
            fontWeight: FontWeight.w900,
          )
              : hintStyle,
          hintText: hintText,
        ),
      ),
    );
  }
}
