import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/custom_button.dart';
import 'package:student_attendence/Widgets/custom_circular_progress.dart';
import '../Widgets/vertical_spacing.dart';

class CourseWiseStudent extends StatelessWidget {

  Future<void> markAttendence(var student, String status) async {
    DocumentReference document = FirebaseFirestore.instance.collection('student').doc(student.id);
    try {
      if (status == "Present") {
        await document.update({
          'status': false,
          'absent': student['absent'],
          'present': student['present'] + 1
        });
      } else {
        await document.update({
          'status': false,
          'absent': student['absent'] + 1,
          'present': student['present']
        });
      }
    } catch (e) {
      print("Error updating attendance: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? course = ModalRoute.of(context)!.settings.arguments as String?;
    final lowerCaseCourse = course?.toLowerCase().trim() ?? "";

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
          title: Text(
            '${course?.toUpperCase()} Students',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('student').snapshots(),
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

            final students = snapshot.data!.docs;

            return Container(
              color: Color(0xFF0B5C98).withOpacity(0.3),
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  final studentCourse = student['course']?.toLowerCase().trim() ?? "";
                  if (studentCourse == lowerCaseCourse) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Roll No.: ${student["id"]}"),
                                      VerticalSpacing(size: 3),
                                      Text("Name: ${student["name"]}"),
                                      VerticalSpacing(size: 3),
                                      Text("Course: ${student["course"]}"),
                                      Text("Phone: ${student["phone"]}"),
                                      VerticalSpacing(size: 10),
                                    ],
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: student['image'] != ""
                                          ? Image.network(student['image'])
                                          : Image.asset("assets/images/user2.png"),
                                    ),
                                  ),
                                ],
                              ),
                              VerticalSpacing(size: 15),
                              Divider(),
                              VerticalSpacing(size: 15),
                              Visibility(
                                visible: student['status'],
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomButton(
                                      callback: () {
                                        markAttendence(student, "Present");
                                      },
                                      btnText: "Present",
                                      btnVerticalPadding: 14,
                                      btnHorizontalPadding: 16.0,
                                      bgColor: Colors.green,
                                    ),
                                    CustomButton(
                                      callback: () {
                                        markAttendence(student, "Absent");
                                      },
                                      btnText: "Absent",
                                      btnVerticalPadding: 14,
                                      btnHorizontalPadding: 16.0,
                                      bgColor: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: !student['status'],
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.green,
                                  child: Icon(Icons.done, size: 35, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
