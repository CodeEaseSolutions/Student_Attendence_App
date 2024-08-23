import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? btnText;
  final VoidCallback? callback;
  Color? bgColor;
  Color? btnTextColor;
  Color? btnBorderColor;
  CustomButton({this.btnText,
    this.callback,
    this.bgColor,
    this.btnTextColor=Colors.white,
    this.btnBorderColor=Colors.transparent
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callback!();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Text(btnText ?? "Submit",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 4,
          foregroundColor: btnTextColor,
          backgroundColor: bgColor!=null ? bgColor :Color(0xFF0B5C98),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
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
