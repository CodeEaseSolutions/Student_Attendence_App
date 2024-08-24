import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_attendence/Screens/main_login_screen.dart';
import 'package:student_attendence/Screens/student_login_screen.dart';
import 'package:student_attendence/Screens/webview_screen.dart';

import 'Screens/teacher_login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MainLoginScreen(),
        '/teacher-login-screen': (context) => TeacherLoginScreen(),
        '/student-login-screen': (context) => StudentLoginScreen(),
        "/website-screen":(context)=>WebSiteScreen()
      },
    );
  }
}
