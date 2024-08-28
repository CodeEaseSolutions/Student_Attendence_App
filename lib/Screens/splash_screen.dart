import 'package:flutter/material.dart';
import 'package:student_attendence/services/sharedPreferences/shared_preferences_service.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isStudentLogin;
  bool? isTeacherLogin;

  checkStudentLogin() async{
    isStudentLogin = await SharedPreferencesService().getStudentLoginStatus();
    isTeacherLogin  = await SharedPreferencesService().getTeacherLoginStatus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStudentLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFF0B5C98),
          child: Center(
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.3, end: 1), // Initial and final scale
              duration: Duration(seconds: 3), // Duration of the animation
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(100.0), // 100.0 makes it a circle
                child: Image.asset(
                "assets/images/logo.jpeg", // Replace with your image URL
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),// Replace with your image
              onEnd: () {
                if(isStudentLogin==true){
                  Navigator.pushNamedAndRemoveUntil(context, '/student-dashboard-screen', (route)=>false);
                }else if(isTeacherLogin==true){
                  Navigator.pushNamedAndRemoveUntil(context, '/teacher-dashboard-screen', (route)=>false);
                }else{
                Navigator.pushReplacementNamed(context, "/main-login-screen");
                }
                },
            ),
          ),
        ),
      ),
    );
  }
}