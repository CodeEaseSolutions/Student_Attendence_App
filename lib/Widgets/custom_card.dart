import 'package:flutter/material.dart';
import 'package:student_attendence/Widgets/vertical_spacing.dart';

class CustomCard extends StatelessWidget {
  String? cardText;
  IconData? cardIcon;
  VoidCallback? callback;
  CustomCard({this.cardText,this.cardIcon,this.callback});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(0xFF0B5C98).withOpacity(0.1),
      onTap: () {
        callback!();
      },
      child:
      Container(
        width: MediaQuery.of(context).size.width*0.46,
        height: MediaQuery.of(context).size.height*0.22,
        child: Card(
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor:Color(0xFF0B5C98),
                radius: 45,
                child: Icon(cardIcon,size: 60,color: Colors.white,),
              ),
              VerticalSpacing(size: 15),
              Text(cardText!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
            ],
          ),
        ),
      ),
    );
  }
}
