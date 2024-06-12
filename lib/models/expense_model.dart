import 'package:flutter/material.dart';
import 'package:expenses_app/data/data.dart';

class ExpenseModel with ChangeNotifier {
  List<Transaction> transactionsList = [];
  List<Category> categoriesList = [
    Category(name: 'Food', color: Colors.blue, icon: Icons.fastfood),
    Category(name: 'Clothing', color: Colors.purple, icon: Icons.shopping_bag),
    Category(name: 'Transportation', color: Colors.yellow, icon: Icons.train),
    Category(name: 'Personal', color: Colors.deepOrange, icon: Icons.person),
  ];

  List<Transaction> get transactions => transactionsList;
  List<Category> get categories => categoriesList;

  double get totalBalance {
    return transactionsList.fold(0.0, (sum, item) => sum + item.totalAmount);
  }

  void addTransaction(Transaction transaction) {
    transactionsList.add(transaction);
    transaction.category.totalAmount += transaction.totalAmount;
    notifyListeners();
  }

  void removeTransaction(int index) {
    categoriesList
        .firstWhere((category) =>
            category.name == transactionsList[index].category.name)
        .totalAmount -= transactionsList[index].totalAmount;
    transactionsList.removeAt(index);
    notifyListeners();
  }

  void updateTransaction(int index, Transaction updatedTransaction) {
    var oldTransaction = transactionsList[index];
    categoriesList
        .firstWhere((category) => category.name == oldTransaction.category.name)
        .totalAmount -= oldTransaction.totalAmount;
    categoriesList
        .firstWhere(
            (category) => category.name == updatedTransaction.category.name)
        .totalAmount += updatedTransaction.totalAmount;

    transactionsList[index] = updatedTransaction;
    notifyListeners();
  }
}
