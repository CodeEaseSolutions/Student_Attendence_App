import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  String label;
  Function(String value) getValue;
  final FormFieldValidator<String>? validator;
  TextInputType? keyBoardType;
  int? maxLength;
  bool? secureText;
  bool? enable;
  bool? phoneValidate;
  bool? emailValidate;
  CustomTextFeild(
      {required this.label,
        required this.getValue,
        this.keyBoardType = TextInputType.text,
        this.secureText = false,
        this.validator,
        this.maxLength,
        this.enable,
        this.phoneValidate =false,
        this.emailValidate=false
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.85,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        enabled: enable,
        keyboardType: keyBoardType,
        onChanged: (value) {
          getValue(value);
        },
        buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
          return null; // Alternatively, you can return an empty container
        },
        validator: (value){
          var phoneValidator = RegExp("^[6789][0-9]{9}\$");
          var emailValidator = RegExp("^[^\\s@]+@[^\\s@]+\\.[cC][oO][mM]\$");

          if(value!.isEmpty){
            return "$label is empty";
          }else if(!emailValidator.hasMatch(value) && emailValidate == true){
            return "Must have @abc and .com";
          }
          else if(!phoneValidator.hasMatch(value) && phoneValidator==true){
            return "Must have 10 digit & start from 6,7,8,9";
          }else {
            return null;
          }
        },
        obscureText: secureText!,
        decoration: InputDecoration(

          label: Text(
            label,
            style: TextStyle(color:Color(0xFF0B5C98)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 15),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF0B5C98), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:Color(0xFF0B5C98), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:Color(0xFF0B5C98), width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF0B5C98), width: 2),
          ),
        ),
      ),
    );
  }
}
