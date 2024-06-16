import 'dart:ui';

// import 'package:expenses_app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/screens/edit_transactions.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome!',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground)),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.bell))
              ],
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
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          color: Colors.grey.shade300,
                          offset: const Offset(5, 5))
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
                  onTap: () {},
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
