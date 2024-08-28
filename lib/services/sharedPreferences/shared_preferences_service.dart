
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

    setStudentLoginStatus({bool status = false}) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isStudentLogin', status);
  }

   getStudentLoginStatus() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isStudentLogin');
  }

    setStudentLoginInfo(String documentId) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', documentId);
    }

    getStudentLoginInfo() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
     return await prefs.getString('id');
    }

   setStudentSignupStatus({bool status = false}) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignup', status);
  }

   getStudentSignupStatus() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isSignup');
  }

    setTeacherLoginStatus({bool status = false}) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isTeacherLogin', status);
    }

    getTeacherLoginStatus() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isTeacherLogin');
    }



}