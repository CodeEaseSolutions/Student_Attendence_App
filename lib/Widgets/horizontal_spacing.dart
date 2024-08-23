import 'package:flutter/material.dart';

class HorizontalSpacing extends StatelessWidget {
  double size;
  HorizontalSpacing({required this.size});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
    );
  }
}
