import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expenses_app/models/expense_model.dart';

class CategoryPieChart extends StatelessWidget {
  const CategoryPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseModel>(
      builder: (context, expenseModel, child) {
        var categoryTotals = expenseModel.categories;
        var totalAmount = categoryTotals.fold(
            0.0, (prev, element) => prev + element.totalAmount);
        var pieChartData = categoryTotals.map((category) {
          return PieChartSectionData(
            color: category.color,
            value: category.totalAmount,
            title:
                '${(category.totalAmount / totalAmount * 100).toStringAsFixed(1)}%',
            radius: 80,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        }).toList();

        return Column(
          children: [
            const Text(
              'Category Distribution',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: pieChartData,
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event,
                        PieTouchResponse? touchResponse) {},
                  ),
                ),
                swapAnimationDuration: Duration(milliseconds: 150),
                swapAnimationCurve: Curves.linear,
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List<Widget>.generate(
                  expenseModel.categories.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundColor: expenseModel.categories[index].color,
                        ),
                        label: Text(expenseModel.categories[index].name),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
