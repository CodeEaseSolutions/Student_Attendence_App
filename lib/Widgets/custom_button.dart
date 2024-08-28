import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? btnText;
  final VoidCallback? callback;
  Color? bgColor;
  Color? btnTextColor;
  Color? btnBorderColor;
  double? btnHorizontalPadding;
  double? btnVerticalPadding;
  CustomButton({this.btnText,
    this.callback,
    this.bgColor,
    this.btnTextColor=Colors.white,
    this.btnBorderColor=Colors.transparent,
    this.btnHorizontalPadding=60,
    this.btnVerticalPadding=18
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callback!();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:btnHorizontalPadding!),
        child: Text(btnText ?? "Submit",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 4,
          foregroundColor: btnTextColor,
          backgroundColor: bgColor!=null ? bgColor :Color(0xFF0B5C98),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: btnVerticalPadding!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
              color: btnBorderColor!,
              width: 2
          )
      ),
    );
  }
}
