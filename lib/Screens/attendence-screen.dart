import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/vertical_spacing.dart';

import '../Widgets/custom_circular_progress.dart';

class AttendenceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0B5C98),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back,color: Colors.white,),),
        title: Text('Student Attendence',style: TextStyle(color: Colors.white),),
      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
                decoration: BoxDecoration(
                    color: Color(0xFF0B5C98),
                    borderRadius: BorderRadius.circular(20)
                ),
                child:Text("Add Student Attendence Based On Cources",
                  textAlign :TextAlign.center ,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
            ),
            VerticalSpacing(size: 30),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('courses').snapshots(),
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CustomCircularProgress());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No data available'));
                  }
                  final courses = snapshot.data!.docs;
                  return
                    ListView.builder(
                      shrinkWrap: true,
                        itemCount: courses.length,
                        itemBuilder: (context,index){
                          final course = courses[index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/course-wise-screen-screen',arguments: course["course"]);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
                                decoration: BoxDecoration(
                                    color: Color(0xFF0B5C98),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child:Text(course["course"],
                                  textAlign :TextAlign.center ,
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
                            ),
                          );
                        }
                    );
                }
            ),
          ],
        ),
      ),
    );
  }
}
