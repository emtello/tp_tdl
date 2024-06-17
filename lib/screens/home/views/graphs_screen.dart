import 'package:flutter/material.dart';
import 'package:expenses_app/screens/graphs/category_pie_chart.dart';
import 'package:expenses_app/screens/graphs/monthly_bar_chart.dart';

class GraphsScreen extends StatelessWidget {
  const GraphsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
              child: Column(
                children: [
                  const CategoryPieChart(),
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
