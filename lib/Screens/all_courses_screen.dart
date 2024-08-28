import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/horizontal_spacing.dart';

import '../Widgets/custom_circular_progress.dart';
import '../Widgets/vertical_spacing.dart';

class ViewCoursesScreen extends StatelessWidget {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  editCourse(){
  }

  deleteCourse( String documentId) async{
    try {
      await firestore.collection('courses').doc(documentId).delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          backgroundColor: Color(0xFF0B5C98),
          title: Text('All Courses', style: TextStyle(color: Colors.white)),
        ),
        body: StreamBuilder(
          stream: firestore.collection('courses').snapshots(),
          builder: (context, snapshot) {
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
            return Container(
              color: Color(0xFF0B5C98).withOpacity(0.3),
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  var timings = course['timing'];
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Course : ${course["course"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              editCourse();
                                              },
                                            child: CircleAvatar(
                                                backgroundColor: Colors.green,
                                                child:Icon(Icons.edit, size: 25, color: Colors.white)),
                                          ),
                                          HorizontalSpacing(size: 10),
                                          GestureDetector(
                                            onTap:(){
                                              deleteCourse(course.id);
                                            },
                                            child: CircleAvatar(
                                                backgroundColor: Colors.red,
                                                child: Icon(Icons.delete, size: 25, color: Colors.white)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  VerticalSpacing(size: 8),
                                  Text("Timing:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                  VerticalSpacing(size: 8),
                                  Container(
                                    height: 40,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: timings.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF0B5C98),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${timings[index]}",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
