import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expenses_app/models/expense_model.dart';

class MonthlyBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseModel = Provider.of<ExpenseModel>(context);
    final currentYear = DateTime.now().year;

    List<BarChartGroupData> barGroups = List.generate(6, (i) {
      final total = expenseModel.monthlyTotal(i + 1, currentYear);
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: total,
            color: Colors.blue,
            width: 16,
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
                    reservedSize: 30,
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text('${(value ~/ 1000)}k'),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // Hide top titles
                ),
                rightTitles: AxisTitles(
                  sideTitles:
                      SideTitles(showTitles: false), // Hide right titles
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
