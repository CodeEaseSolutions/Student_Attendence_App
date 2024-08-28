import 'package:flutter/material.dart';
import '../Widgets/custom_card.dart';
import '../Widgets/vertical_spacing.dart';
import '../services/sharedPreferences/shared_preferences_service.dart';

class TeacherDashboardScreen extends StatefulWidget {

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {

  // updateDatabase() async{
  //   var firestore = FirebaseFirestore.instance;
  //   try {
  //     QuerySnapshot documents = await firestore.collection('student').get();
  //     for (QueryDocumentSnapshot document in documents.docs) {
  //       await firestore.collection('student').doc(document.id).update({
  //         'status': true,
  //       });
  //     }
  //     print('All documents updated successfully');
  //   } catch (e) {
  //     print('Error updating documents: $e');
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   DateTime now = DateTime.now();
  //   DateFormat timeFormat = DateFormat('ha');
  //   String formattedTime = timeFormat.format(now);
  //  if(formattedTime == "4AM"){
  //    updateDatabase();
  //  }
  // }

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    final String teacherName = arguments is String ? arguments : 'Ayush';
    return SafeArea(child:  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0B5C98),
        title: Text(teacherName,style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: () async{
            await SharedPreferencesService().setTeacherLoginStatus(status: false);
            Navigator.pushNamedAndRemoveUntil(context, '/main-login-screen', (route)=>false);
          }, icon:Icon(Icons.logout,color: Colors.white,) )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            VerticalSpacing(size: 30),
            Wrap(
              runSpacing: 10,
              spacing: 8,
              direction: Axis.horizontal,
              children: [
                CustomCard(
                    cardText: "ATTENDENCE",
                    cardIcon: Icons.bookmark_added,
                    callback:(){
                      Navigator.pushNamed(context, "/attendence-screen");
                    }
                ),
                CustomCard(
                    cardText: "ADD COURSE",
                    cardIcon: Icons.book,
                    callback:(){
Navigator.pushNamed(context, '/add-course-screen');
                    }
                ),
                CustomCard(
                    cardText: "ALL STUDENTS",
                    cardIcon: Icons.person,
                    callback:(){
                      Navigator.pushNamed(context, '/all-students-screen');
                    }
                ),
                CustomCard(
                    cardText: "ALL COURSES",
                    cardIcon: Icons.table_view,
                    callback:(){
                      Navigator.pushNamed(context, '/view-courses-screen');
                    }
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
