import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/custom_button.dart';

import '../Widgets/vertical_spacing.dart';

class MainLoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    Container(
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
                                radius: 110,
                                backgroundColor: Colors.orange,
                                child:
                                CircleAvatar(
                                  radius: 105,
                                  backgroundImage:AssetImage("assets/images/student_login.png"),
                                ),

                              ),
                              VerticalSpacing(size: 30),
                              Text("STUDENT LOGIN!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 30))
                            ]
                        ),
                      ),
                    ),
                    Container(
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
                                radius: 110,
                                backgroundColor: Colors.orange,
                                child:
                                CircleAvatar(
                                  radius: 105,
                                  backgroundImage:AssetImage("assets/images/student_login.png"),
                                ),

                              ),
                              VerticalSpacing(size: 30),
                              Text("TEACHER LOGIN!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 30))
                            ]
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height*0.52,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 2500),
                      viewportFraction: 0.8
                  ),
                ),
                VerticalSpacing(size: 100),
                CustomButton(btnText: "LOGIN IN WEBSITE",bgColor: Colors.white,btnTextColor:  Color(0xFF0B5C98),)
              ],
            )
            ),
          )
      );
  }
}
