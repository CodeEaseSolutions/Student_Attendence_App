import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/custom_button.dart';

import '../Widgets/custom_textfeild.dart';
import '../Widgets/vertical_spacing.dart';

class StudentLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child:
            Container(
              color: Color(0xFF0B5C98).withOpacity(0.3),
              child: Column(
                children: [
                  VerticalSpacing(size: 65),
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.orange,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 95,
                          backgroundImage:AssetImage("assets/images/student_login.png"),
                        ),
                      ],
                    ),
                  ),
                  VerticalSpacing(size: 65),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.61,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            VerticalSpacing(size: 60),
                            Text("WELCOME!",style: TextStyle(fontSize: 40),),
                            VerticalSpacing(size: 40),
                            CustomTextFeild(
                              label: "Name",
                              getValue: (value) {
                              },
                              keyBoardType: TextInputType.number,
                            ),
                            VerticalSpacing(size: 20),
                            CustomTextFeild(
                              label: "Password",
                              getValue: (value) {
                              },
                              keyBoardType: TextInputType.number,
                            ),
                            VerticalSpacing(size: 40),
                            CustomButton(btnText: "LOGIN",)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
