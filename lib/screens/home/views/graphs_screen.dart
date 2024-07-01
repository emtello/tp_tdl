import 'package:flutter/material.dart';
import 'package:expenses_app/screens/graphs/category_pie_chart.dart';
import 'package:expenses_app/screens/graphs/monthly_bar_chart.dart';

class GraphsScreen extends StatelessWidget {
  const GraphsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
              child: Column(
                children: [
                  CategoryPieChart(),
                  Expanded(
                    child: MonthlyBarChart(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
