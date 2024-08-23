import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  double size;
  VerticalSpacing({required this.size});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
