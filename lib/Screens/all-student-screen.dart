import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/custom_button.dart';
import 'package:student_attendence/Widgets/custom_circular_progress.dart';

import '../Widgets/vertical_spacing.dart';

class AllStudentsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar:  AppBar(
        leading:  IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back,color: Colors.white,) ),
        backgroundColor: Color(0xFF0B5C98),
        title: Text('Students',style: TextStyle(color: Colors.white),),

      ),
      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('student').snapshots(),
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
          final students = snapshot.data!.docs;
          return Container(
            color: Color(0xFF0B5C98).withOpacity(0.3),
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context,index){
                  final student = students[index];
                  return Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                        child: Column(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Text("Roll No. : ${student["id"]}"),
                                    VerticalSpacing(size: 3),
                                    Text("Name : ${student["name"]}"),
                                    VerticalSpacing(size: 3),
                                    Text("Course : ${student["course"]}"),
                                    Text("Phone : ${student["phone"]}"),
                                    VerticalSpacing(size: 10),
                                  ],
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: student['image']!="" ?  Image.network(student['image']): Image.asset("assets/images/user2.png"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
      }
      ),
    ));
  }
}
