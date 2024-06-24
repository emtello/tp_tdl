import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/models/expense_model.dart';

class ExportDataScreen extends StatefulWidget {
  @override
  _ExportDataScreenState createState() => _ExportDataScreenState();
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text('Export data',
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
                  SizedBox(height: 8),
                  Text(
                    'Export your transactions and use them in Excel, Numbers, Google Spreadsheets etc.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(
              'From:',
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              onTap: () => _selectDate(context, true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(fromDate),
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            Text(
              'To:',
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              onTap: () => _selectDate(context, false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(toDate),
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Consumer<ExpenseModel>(
                    builder: (context, expenseModel, child) {
                      final filteredTransactions =
                          expenseModel.transactions.where((transaction) {
                        return transaction.date.isAfter(
                                fromDate.subtract(Duration(days: 1))) &&
                            transaction.date
                                .isBefore(toDate.add(Duration(days: 1)));
                      }).toList();

                      return Text(
                        'FOUND A TOTAL OF ${filteredTransactions.length} TRANSACTIONS',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final transactions =
                          Provider.of<ExpenseModel>(context, listen: false)
                              .transactions
                              .where((transaction) {
                        return transaction.date.isAfter(fromDate) &&
                            transaction.date
                                .isBefore(toDate.add(Duration(days: 1)));
                      }).toList();

                      ExpenseModel.exportToCSV(transactions).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Transactions exported to CSV')),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Failed to export transactions')),
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
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
