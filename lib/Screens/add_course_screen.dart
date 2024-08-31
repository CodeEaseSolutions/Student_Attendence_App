import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/custom_button.dart';
import 'package:student_attendence/Widgets/horizontal_spacing.dart';

import '../Widgets/custom_textfeild.dart';
import '../Widgets/vertical_spacing.dart';

class AddCourseScreen extends StatefulWidget {
  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  String? course;
 TextEditingController time = TextEditingController();
  List<String> timings=[];
  final form_key = GlobalKey<FormState>();

  final firestore = FirebaseFirestore.instance;

  Future<void> _submit() async {
    bool isCourseAvailable=false;
    try{
      QuerySnapshot  documents = await firestore.collection("courses").get();
      for(QueryDocumentSnapshot document in documents.docs){
        if(document['course'].toLowerCase()==course?.toLowerCase()){
          isCourseAvailable = false;
        }else{
          isCourseAvailable=true;
        }
      }

     if(isCourseAvailable){
       var courses = firestore.collection("courses");
       await courses.add({
         "course":course,
         "timing":timings
       });
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         content: Text('Course added successfully'),
       ));
     }else{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         content: Text('Course already added'),
       ));
     }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Course not added'),
      ));
      print("Error to add course"+e.toString());
    }
    course="";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0B5C98),
        title: Text(
          'Add Course',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFF0B5C98).withOpacity(0.3),
            child: Column(
              children: [
                VerticalSpacing(size: 30),
                CircleAvatar(
                  radius: 96,
                  backgroundColor: Colors.orange,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 91,
                        backgroundImage: AssetImage("assets/images/student_login.png"),
                      ),
                    ],
                  ),
                ),
                VerticalSpacing(size: 30),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
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
                          Text(
                            "ADD NEW COURSE!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                          ),
                          VerticalSpacing(size: 30),
                          CustomTextFeild(
                            label: "Course Name",
                            getValue: (value) {
                              course = value;
                            },
                          ),
                          VerticalSpacing(size: 20),
                          // Row to align the text field and the '+' icon
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: time,
                                    decoration: InputDecoration(
                                      label: Text(
                                        "Timing",
                                        style: TextStyle(color: Color(0xFF0B5C98)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Color(0xFF0B5C98), width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Color(0xFF0B5C98), width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Color(0xFF0B5C98), width: 2),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Color(0xFF0B5C98), width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                             HorizontalSpacing(size: 4),
                                GestureDetector(
                                  onTap: () {
                                    if (time.text.isNotEmpty) {
                                      timings.add(time.text.toString());
                                      time.clear();
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF0B5C98),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalSpacing(size: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
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
                                    borderRadius: BorderRadius.circular(20),
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
                          VerticalSpacing(size: 30),
                          CustomButton(
                            btnText: "ADD",
                            callback: () {
                              if (form_key.currentState!.validate()) {
                                if (timings.isNotEmpty) {
                                  _submit();
                                  Navigator.pushReplacementNamed(context, "/teacher-dashboard-screen");
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please enter timing of course'),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
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
