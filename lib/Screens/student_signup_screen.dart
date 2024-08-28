
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:student_attendence/Widgets/custom_button.dart';
import 'package:student_attendence/Widgets/custom_dropdown_button.dart';
import 'package:student_attendence/services/sharedPreferences/shared_preferences_service.dart';

import '../Widgets/custom_textfeild.dart';
import '../Widgets/vertical_spacing.dart';

class StudentSignupScreen extends StatefulWidget {
  @override
  State<StudentSignupScreen> createState() => _StudentSignupScreenState();
}

class _StudentSignupScreenState extends State<StudentSignupScreen> {


  String userId="";
  String name="";
  String course="";
  String timing="";
  String phone="";
  final form_key = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? _profileImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile.path;
      });
    }
  }

  Future<String> _uploadImage(String file) async {
   try{
     final fileName = DateTime.now().millisecondsSinceEpoch.toString();
     final ref = _storage.ref().child('profile_images').child(fileName);
     final uploadTask = ref.putFile(File(_profileImage!));
     final snapshot = await uploadTask;
     final imageUrl = await snapshot.ref.getDownloadURL();
     return imageUrl;
   }catch(e){
     print("image error"+e.toString());
     return e.toString();
   }
  }

  Future<void> _submit() async {
    var userId = DateTime.now().millisecondsSinceEpoch.toString();
    if (name.isEmpty || course.isEmpty || timing.isEmpty || phone.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please fill in all fields'),
        ));
      }
      return;
    }

    try {
      String? profileImageUrl;
      if (_profileImage != null) {
        profileImageUrl = await _uploadImage(_profileImage!);
      }

      var student = firestore.collection("student");
      await student.add({
        'id': userId,
        'name': name,
        'course': course,
        'timing': timing,
        'phone': phone,
        'absent': 0,
        'present': 0,
        'status': true,
        if (profileImageUrl != null) 'image': profileImageUrl
        else 'image':"",
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User data added successfully'),
        ));
      }

      await SharedPreferencesService().setStudentSignupStatus(status: true);

      if (mounted) {
        Navigator.pushReplacementNamed(context, "/student-login-screen");
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add user data'),
        ));
      }
    }

    // Clear form fields
    if (mounted) {
      setState(() {
        userId = "";
        name = "";
        course = "";
        timing = "";
        phone = "";
        _profileImage = null;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFF0B5C98).withOpacity(0.3),
            child: Column(
              children: [
                VerticalSpacing(size: 65),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFF0B5C98),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: _profileImage == null
                            ? AssetImage("assets/images/user2.png")
                            : FileImage(File(_profileImage!)),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () async {
                            await _pickImage();
                          },
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Color(0xFF0B5C98),
                            child: Icon(
                              Icons.camera_alt,
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalSpacing(size: 65),
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.72,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Form(
                      key : form_key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VerticalSpacing(size: 60),
                          CustomTextFeild(
                            label: "Name",
                            getValue: (value) {
                              name = value;
                            },
                          ),
                          VerticalSpacing(size: 20),
                          CustomDropDown(
                            items: [
                              'JAVA',
                              'Python',
                            ],
                            hint: 'Course',
                            getValue: (value){
                              course = value;
                            },
                          ),
                          VerticalSpacing(size: 20),
                          CustomDropDown(
                            items: [
                              '8-9AM',
                              '9-10AM',
                              '10-11AM',
                              '11-12PM',
                              '12-1PM',
                              '1-2PM',
                              '2-3PM',
                              '3-4PM',
                              '4-5PM',
                              '5-6PM',
                              '6-7PM',
                              '7-8PM',
                              '8-9PM',
                              '9-10PM'
                            ],
                            hint: "Timing",
                            getValue: (value){
                              timing = value;
                            },
                          ),
                          VerticalSpacing(size: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: IntlPhoneField(
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(color: Color(0xFF0B5C98)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 22, horizontal: 15),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xFF0B5C98), width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xFF0B5C98), width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xFF0B5C98), width: 2),
                                ),
                              ),
                              initialCountryCode: 'IN',
                              onChanged: (phoneNumber) {
                                phone = phoneNumber.completeNumber;
                              },
                            ),
                          ),
                          VerticalSpacing(size: 20),
                          CustomButton(
                            btnText: "SIGNUP",
                            callback: () async{
                              if(form_key.currentState!.validate()){
                               bool? isSignup = await SharedPreferencesService().getStudentSignupStatus();
                               if(isSignup == null && isSignup !=true){
                                 _submit();
                               }else{
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                   content: Text('Student already exist (Login Now)'),
                                 ));
                               }
                                Navigator.pushReplacementNamed(
                                    context, "/student-login-screen");
                              }

                            },
                          ),
                          VerticalSpacing(size: 20),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, "/student-login-screen");
                            },
                            child: Text(
                              "Have An Account? Login!",
                              style: TextStyle(color: Color(0xFF0B5C98)),
                            ),
                          ),
                          VerticalSpacing(size: 10),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
