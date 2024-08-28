import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/vertical_spacing.dart';

class AttendenceViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot? student = ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;
    int totalClasses = student['present']+student['absent'];
    int present=student['present'];
    double presentage = (present/totalClasses)*100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0B5C98),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back,color: Colors.white,),),
        title: Text('Attendence Calculator',style: TextStyle(color: Colors.white),),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
         decoration: BoxDecoration(
           color: Color(0xFF0B5C98),
           borderRadius: BorderRadius.circular(20)
         ),
              child: Center(
                  child: Text("Average Attendence -> 70%",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
              )
          ),
          VerticalSpacing(size: 30),
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            child: Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("Course : ${student['course']}"),
                        VerticalSpacing(size: 3),
                        Text("Present : ${student['present']}"),
                        VerticalSpacing(size: 3),
                        Text("Absent : ${student['absent']}"),
                        VerticalSpacing(size: 3),
                        Text("Total Classes : ${totalClasses}"),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: presentage/100,
                            strokeWidth: 5,
                            color:  Color(0xFF0B5C98),
                          ),
                        ),
                        Text(
                          '${(presentage).toStringAsFixed(1)}%',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
