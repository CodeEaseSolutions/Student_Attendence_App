import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/custom_button.dart';

import '../Widgets/vertical_spacing.dart';

class MainLoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(0xFF0B5C98),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider(
                    items: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/student-login-screen");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45),
                            child: Column(
                                children:[
                                  VerticalSpacing(size: 30),
                                  CircleAvatar(
                                    radius: 90,
                                    backgroundColor:  Color(0xFF0B5C98),
                                    child:
                                    CircleAvatar(
                                      radius: 85,
                                      backgroundImage:AssetImage("assets/images/user2.png"),
                                    ),

                                  ),
                                  VerticalSpacing(size: 35),
                                  Text("STUDENT LOGIN!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Color(0xFF0B5C98)))
                                ]
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "/teacher-login-screen");
                          },
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: Column(
                              children:[
                                VerticalSpacing(size: 30),
                                CircleAvatar(
                                  radius: 90,
                                  backgroundColor:  Color(0xFF0B5C98),
                                  child:
                                  CircleAvatar(
                                    radius: 85,
                                    backgroundImage:AssetImage("assets/images/user2.png"),
                                  ),

                                ),
                                VerticalSpacing(size: 35),
                                Text("TEACHER LOGIN!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Color(0xFF0B5C98)))
                              ]
                          ),
                        ),
                      )),
                    ],
                    options: CarouselOptions(
                        height: MediaQuery.of(context).size.height*0.5,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 2500),
                        viewportFraction: 0.8
                    ),
                  ),
                  VerticalSpacing(size: 80),
                  CustomButton(btnText: "LOGIN IN WEBSITE",
                    callback: (){
                    Navigator.pushNamed(context, "/website-screen");
                    },
                    bgColor: Colors.white,btnTextColor: Color(0xFF0B5C98),)
                ],
              )
              ),
          ),
          )
      );
  }
}
