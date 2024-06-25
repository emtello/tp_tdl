import 'package:flutter/material.dart';
import 'package:expenses_app/data/data.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class ExpenseModel with ChangeNotifier {
  List<Transaction> transactionsList = [];

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

  double monthlyTotal(int month, int year) {
    return transactionsList
        .where((transaction) =>
            transaction.date.month == month && transaction.date.year == year)
        .fold(0.0, (sum, item) => sum + item.totalAmount);
  }

  double monthlyTotalByCategory(Category category, int month, int year) {
    return transactionsList
        .where((transaction) =>
            transaction.date.month == month &&
            transaction.date.year == year &&
            transaction.category.name == category.name)
        .fold(0.0, (sum, item) => sum + item.totalAmount);
  }

  //For exporting

  static Future<void> exportToCSV(List<Transaction> transactions) async {
    List<List<String>> data = [
      ['Name', 'Amount', 'Date', 'Category']
    ];

    for (var transaction in transactions) {
      data.add([
        transaction.name,
        transaction.totalAmount.toString(),
        DateFormat('dd/M/yy').format(transaction.date),
        transaction.category.name
      ]);
    }

    String csvData = const ListToCsvConverter().convert(data);

    final directory = await getExternalStorageDirectory();
    final path = "${directory!.path}/transactions.csv";
    final file = File(path);
    await file.writeAsString(csvData);
  }
}
