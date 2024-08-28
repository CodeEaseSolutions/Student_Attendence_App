import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/custom_button.dart';
import 'package:student_attendence/services/sharedPreferences/shared_preferences_service.dart';

import '../Widgets/custom_textfeild.dart';
import '../Widgets/vertical_spacing.dart';

class StudentLoginScreen extends StatelessWidget {
  String rollNumber="";
  String name="";
  final form_key = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  checkLoginDetails(var context) async{
    try{
      QuerySnapshot  documents = await firestore.collection("student").get();
      for(QueryDocumentSnapshot document in documents.docs){
      if(document['id'] == rollNumber){
       await SharedPreferencesService().setStudentLoginStatus(status: true);
       await SharedPreferencesService().setStudentLoginInfo(document.id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$name Login Successfully...'),
        ));
        Navigator.pushNamedAndRemoveUntil(context, "/student-dashboard-screen",(route)=>false);
        return;
      }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Details'),
      ));
      return;
     }catch(e){
      print(e.toString());
      return;
    }
  }

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
                    backgroundColor: Color(0xFF0B5C98),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 95,
                          backgroundImage:AssetImage("assets/images/user2.png"),
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
                      key: form_key,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            VerticalSpacing(size: 50),
                            Text("WELCOME!",style: TextStyle(fontSize: 40),),
                            VerticalSpacing(size: 30),
                            CustomTextFeild(
                              label: "Name",
                              getValue: (value) {
                                name=value;
                              },
                            ),
                            VerticalSpacing(size: 20),

                            CustomTextFeild(
                              label: "Roll No.",
                              getValue: (value) {
                                rollNumber = value;
                              },
                              keyBoardType: TextInputType.number,
                            ),
                            VerticalSpacing(size: 30),
                            CustomButton(btnText: "LOGIN",
                            callback: (){
                             if(form_key.currentState!.validate()){
                               checkLoginDetails(context);
                             }
                            },
                            ),
                            VerticalSpacing(size: 20),
                            InkWell(
                                onTap: () async{
                                  bool? isStudentSignup;
                                  isStudentSignup = await SharedPreferencesService().getStudentSignupStatus();
                                  if(isStudentSignup==true){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('You already signup your account'),
                                    ));
                                  }else {
                                    Navigator.pushNamed(
                                        context, "/student-signup-screen");
                                  }
                                },
                                child: Text("Don't Have An Account?Signup!",style: TextStyle(color:  Color(0xFF0B5C98)),))
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
