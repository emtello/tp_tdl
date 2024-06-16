import 'package:expenses_app/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

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
              child: Consumer<ExpenseModel>(
                builder: (context, expenseModel, child) {
                  var categoryTotals = expenseModel.categories;
                  var totalAmount = categoryTotals.fold(
                      0.0, (prev, element) => prev + element.totalAmount);
                  var data = categoryTotals.map((category) {
                    return PieChartSectionData(
                      color: category.color,
                      value: category.totalAmount,
                      title:
                          '${(category.totalAmount / totalAmount * 100).toStringAsFixed(1)}%',
                      radius: 100,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  }).toList();

                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: PieChart(
                            PieChartData(
                              sections: data,
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
                            swapAnimationDuration:
                                Duration(milliseconds: 150), // Optional
                            swapAnimationCurve: Curves.linear, // Optional
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        child: Wrap(
                          spacing: 5.0,
                          runSpacing: 2.0,
                          children: List<Widget>.generate(
                            expenseModel.categories.length,
                            (index) {
                              return Chip(
                                avatar: CircleAvatar(
                                  backgroundColor:
                                      expenseModel.categories[index].color,
                                ),
                                label:
                                    Text(expenseModel.categories[index].name),
                              );
                            },
                          ),
                        ),
                      ),
                      // Expanded(
                      //   // grafico de los meses
                      // ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
