import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expenses_app/models/expense_model.dart';

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseModel = Provider.of<ExpenseModel>(context);
    final currentYear = DateTime.now().year;

    List<BarChartGroupData> barGroups = List.generate(6, (i) {
      List<BarChartRodStackItem> rodStackItems = [];
      double runningTotal = 0.0;

      for (var category in expenseModel.categories) {
        double categoryTotal =
            expenseModel.monthlyTotalByCategory(category, i + 1, currentYear);
        rodStackItems.add(BarChartRodStackItem(
          runningTotal,
          runningTotal + categoryTotal,
          category.color,
        ));
        runningTotal += categoryTotal;
      }

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: runningTotal,
            color: Colors.blue,
            width: 20,
            rodStackItems: rodStackItems,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
            ),
          ),
        ],
      );
    });

    return Column(
      children: [
        const Text(
          'Monthly Expenses',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: barGroups,
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 32,
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text('${(value ~/ 1000)}k'),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 40,
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const months = [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                      ];
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(months[value.toInt()]),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
