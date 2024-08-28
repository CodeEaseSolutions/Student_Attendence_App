import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPiechart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PieChart(
          swapAnimationCurve: Curves.linearToEaseOut,
          swapAnimationDuration: Duration(seconds: 1),
          PieChartData(

            sections: [
              PieChartSectionData(
                color: Colors.blue,
                value: 40,
                title: '40%',
                radius: 60,
                titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                color: Colors.red,
                value: 30,
                title: 'Java',
                radius: 60,
                titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                color: Colors.green,
                value: 20,
                title: '20%',
                radius: 60,
                titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                color: Colors.yellow,
                value: 20,
                title: '10%',
                radius: 60,
                titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
            centerSpaceRadius:50,
            sectionsSpace: 10,
          ),
        ),
      ),
    );
  }
}
