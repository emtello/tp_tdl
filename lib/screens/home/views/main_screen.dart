import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/screens/add/edit_transactions.dart';
import 'package:expenses_app/screens/transactions/all_transactions.dart';
import 'dart:math' as math;

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Welcome!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 20.0),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary,
                      ],
                      transform: const GradientRotation(math.pi / 2),
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 5.0),
                        blurRadius: 5.0,
                      ),
                    ]),
                child: Consumer<ExpenseModel>(
                  builder: (context, transactionModel, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your Balance',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '\$${transactionModel.totalBalance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                )),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transactions',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllTransactionsScreen(),
                      ),
                    );
                  },
                  child: Text('View All',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<ExpenseModel>(
                builder: (context, transactionModel, child) {
                  var recentTransactions =
                      transactionModel.transactions.reversed.take(5).toList();
                  return ListView.builder(
                    itemCount: recentTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = recentTransactions[index];
                      return ListTile(
                        leading: Icon(transaction.category.icon,
                            color: transaction.category.color),
                        title: Text(transaction.name),
                        subtitle: Text(
                            '${transaction.category.name}\n${transaction.date.year}/${transaction.date.month}/${transaction.date.day}'),
                        trailing: Text(
                            '\$${transaction.totalAmount.toStringAsFixed(2)}'),
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
          ],
        ),
      ),
    );
  }
}
