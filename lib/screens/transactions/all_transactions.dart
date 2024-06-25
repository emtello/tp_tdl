import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/screens/add/edit_transactions.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ExpenseModel>(
          builder: (context, transactionModel, child) {
            return ListView.builder(
              itemCount: transactionModel.transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactionModel.transactions[index];
                return ListTile(
                  leading: Icon(transaction.category.icon,
                      color: transaction.category.color),
                  title: Text(transaction.name),
                  subtitle: Text(
                      '${transaction.category.name}\n${transaction.date.year}/${transaction.date.month}/${transaction.date.day}'),
                  trailing:
                      Text('\$${transaction.totalAmount.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTransactionScreen(
                          transaction: transaction,
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
