import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_attendence/Widgets/custom_card.dart';
import 'package:student_attendence/Widgets/custom_circular_progress.dart';
import 'package:student_attendence/Widgets/vertical_spacing.dart';
import 'package:student_attendence/services/sharedPreferences/shared_preferences_service.dart';

class StudentDashboardScreen extends StatefulWidget {
  @override
  _StudentDashboardScreenState createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  File? _image;
  bool isLoading=true;
  DocumentSnapshot? student;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${pickedFile.name}';

      // Save the image to the app's directory
      final savedImage = await File(pickedFile.path).copy(imagePath);

      if (mounted) {
        setState(() {
          _image = savedImage;
        });
      }
    }
  }

  Future<void> getStudentDetails() async {
    try {
      String? id = await SharedPreferencesService().getStudentLoginInfo();
      if (id != null) {
        QuerySnapshot documents = await firestore.collection("student").get();
        for (QueryDocumentSnapshot document in documents.docs) {
          if (document.id == id) {
            if (mounted) {
              setState(() {
                student = document;
                isLoading=false;
              });
            }
            return;
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getStudentDetails();
  }

  @override
  Widget build(BuildContext context) {
    String studentId = student?.get('id') ?? '12345678'; // Use get method for DocumentSnapshot
    String studentName = student?.get('name') ?? '';
    String? studentImage = student?.get('image');

    return SafeArea(
      child:  Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0B5C98),
          title: Text('Hello, $studentName', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              onPressed: () async {
                await SharedPreferencesService().setStudentLoginStatus(status: false);
                Navigator.pushNamedAndRemoveUntil(context, '/main-login-screen', (route)=>false);
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],
        ),
        body:  isLoading? Center(child: CustomCircularProgress()) : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3, // Fixed container size
                decoration: BoxDecoration(
                  color: Color(0xFF0B5C98),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 65,
                            backgroundImage: studentImage == ""
                                ? AssetImage("assets/images/user1.png")
                                : NetworkImage(studentImage!),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 21,
                                  color: Color(0xFF0B5C98),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalSpacing(size: 20),
                    Text(studentId, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    VerticalSpacing(size: 2),
                    Text(studentName, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              VerticalSpacing(size: 30),
              Wrap(
                runSpacing: 10,
                spacing: 8,
                direction: Axis.horizontal,
                children: [
                  CustomCard(
                    cardText: "ATTENDANCE",
                    cardIcon: Icons.bookmark_added,
                    callback: () {
                      Navigator.pushNamed(context, "/attendence-view-screen",arguments: student);
                    },
                  ),
                  CustomCard(
                    cardText: "CALENDAR",
                    cardIcon: Icons.calendar_month,
                    callback: () {},
                  ),
                  CustomCard(
                    cardText: "CONTACT US",
                    cardIcon: Icons.phone,
                    callback: () {},
                  ),
                  CustomCard(
                    cardText: "TIME TABLE",
                    cardIcon: Icons.table_view,
                    callback: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
