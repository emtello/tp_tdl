import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transaction {
  final IconData icon;
  final String name;
  final Color color;
  final String totalAmount;
  final String date;
  final String category;

  Transaction({
    required this.icon,
    required this.name,
    required this.color,
    required this.totalAmount,
    required this.date,
    required this.category,
  });
}

List<Transaction> transactionData = [
  Transaction(
    icon: CupertinoIcons.table,
    name: 'Food',
    color: Colors.purple,
    totalAmount: '-5500.00',
    date: 'today',
    category: 'Food',
  ),
  Transaction(
    icon: CupertinoIcons.shopping_cart,
    name: 'Shopping',
    color: Colors.indigo,
    totalAmount: '-6000.00',
    date: 'today',
    category: 'Clothing',
  ),
  Transaction(
    icon: CupertinoIcons.car,
    name: 'Gas',
    color: Colors.yellow,
    totalAmount: '-7000.00',
    date: 'today',
    category: 'Transportation',
  ),
  Transaction(
    icon: CupertinoIcons.heart_fill,
    name: 'Gym',
    color: Colors.deepOrange,
    totalAmount: '-2000.00',
    date: 'today',
    category: 'Personal',
  ),
];
