import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/models/expense_model.dart';

class ExportDataScreen extends StatefulWidget {
  const ExportDataScreen({super.key});

  @override
  State<ExportDataScreen> createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  DateTime fromDate = DateTime.now().subtract(Duration(days: 30));
  DateTime toDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Export data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'lib/images/csv.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Export your transactions and use them in Excel, Numbers, Google Spreadsheets etc.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'From:',
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              onTap: () => _selectDate(context, true),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(fromDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const Text(
              'To:',
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              onTap: () => _selectDate(context, false),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(toDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Consumer<ExpenseModel>(
                    builder: (context, expenseModel, child) {
                      final filteredTransactions =
                          expenseModel.transactions.where((transaction) {
                        return transaction.date.isAfter(
                                fromDate.subtract(const Duration(days: 1))) &&
                            transaction.date
                                .isBefore(toDate.add(const Duration(days: 1)));
                      }).toList();

                      return Text(
                        'FOUND A TOTAL OF ${filteredTransactions.length} TRANSACTIONS',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final transactions =
                          Provider.of<ExpenseModel>(context, listen: false)
                              .transactions
                              .where((transaction) {
                        return transaction.date.isAfter(fromDate) &&
                            transaction.date
                                .isBefore(toDate.add(const Duration(days: 1)));
                      }).toList();

                      ExpenseModel.exportToCSV(transactions).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Transactions exported to CSV')),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to export transactions')),
                        );
                      });
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: Text('EXPORT', style: TextStyle(fontSize: 16)),
                    ),
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
