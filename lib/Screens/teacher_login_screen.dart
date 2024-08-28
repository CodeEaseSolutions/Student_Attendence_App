import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/custom_button.dart';

import '../Widgets/custom_textfeild.dart';
import '../Widgets/vertical_spacing.dart';
import '../services/sharedPreferences/shared_preferences_service.dart';

class TeacherLoginScreen extends StatelessWidget {
  String password="";
  String name="";
  final form_key = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  checkLoginDetails(var context) async{
    try{
      QuerySnapshot  documents = await firestore.collection("teachers").get();
      for(QueryDocumentSnapshot document in documents.docs){
        if(document['password'] == password){
          await SharedPreferencesService().setTeacherLoginStatus(status: true);
          await SharedPreferencesService().setStudentLoginStatus(status: false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$name Login Successfully...'),
          ));
          Navigator.pushNamedAndRemoveUntil(context, "/teacher-dashboard-screen",(route)=>false,arguments: name);
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
                          backgroundImage:AssetImage("assets/images/user1.png"),
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

                            VerticalSpacing(size: 60),
                            Text("WELCOME!",style: TextStyle(fontSize: 40),),
                            VerticalSpacing(size: 40),
                            CustomTextFeild(
                              label: "Name",
                              getValue: (value) {
                                name=value;
                              },

                            ),
                            VerticalSpacing(size: 20),
                            CustomTextFeild(
                              label: "Password",
                              getValue: (value) {
                                password=value;
                              },
                              keyBoardType: TextInputType.number,
                            ),
                            VerticalSpacing(size: 40),
                            CustomButton(btnText: "LOGIN",callback: (){
                              if(form_key.currentState!.validate()){
                                checkLoginDetails(context);
                              }
                              },)
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
