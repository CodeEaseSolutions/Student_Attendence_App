import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_attendence/Screens/add_course_screen.dart';
import 'package:student_attendence/Screens/all-student-screen.dart';
import 'package:student_attendence/Screens/attendence-screen.dart';
import 'package:student_attendence/Screens/attendence_view_screen.dart';
import 'package:student_attendence/Screens/course_wise_student.dart';
import 'package:student_attendence/Screens/main_login_screen.dart';
import 'package:student_attendence/Screens/splash_screen.dart';
import 'package:student_attendence/Screens/student_dashboard_screen.dart';
import 'package:student_attendence/Screens/student_login_screen.dart';
import 'package:student_attendence/Screens/student_signup_screen.dart';
import 'package:student_attendence/Screens/teacher_dashboard_screen.dart';
import 'package:student_attendence/Screens/all_courses_screen.dart';
import 'package:student_attendence/Screens/webview_screen.dart';

import 'Screens/teacher_login_screen.dart';
import 'firebase_options.dart';


// Callback function to be executed by the alarm
void alarmCallback() {
  print('Alarm triggered! Performing background task...');
  updateDatabase();
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // Initialize Android Alarm Manager
  await AndroidAlarmManager.initialize();

  // Schedule a periodic alarm
  AndroidAlarmManager.periodic(
    Duration(minutes: 20),
    0,
    alarmCallback,
    exact: true,  // Ensure the alarm is triggered exactly every 20 minutes
    wakeup: true, // Wakes up the device if it's asleep
  );

  runApp(MyApp());

}


updateDatabase() async{
  var firestore = FirebaseFirestore.instance;
  try {
    QuerySnapshot documents = await firestore.collection('student').get();
    for (QueryDocumentSnapshot document in documents.docs) {
      await firestore.collection('student').doc(document.id).update({
        'status': true,
      });
    }
    print('All documents updated successfully');
  } catch (e) {
    print('Error updating documents: $e');
  }
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/main-login-screen': (context) => MainLoginScreen(),
        '/teacher-login-screen': (context) => TeacherLoginScreen(),
        '/student-login-screen': (context) => StudentLoginScreen(),
        '/student-signup-screen': (context) => StudentSignupScreen(),
        '/teacher-dashboard-screen':(context)=>TeacherDashboardScreen(),
        '/student-dashboard-screen':(context)=>StudentDashboardScreen(),
        '/attendence-screen':(context)=>AttendenceScreen(),
        '/attendence-view-screen':(context)=>AttendenceViewScreen(),
        '/all-students-screen':(context)=>AllStudentsScreen(),
        '/add-course-screen':(context)=>AddCourseScreen(),
        '/view-courses-screen':(context)=>ViewCoursesScreen(),
        '/course-wise-screen-screen':(context)=>CourseWiseStudent(),
        "/website-screen":(context)=>WebSiteScreen(),
      },
    );
  }
}
