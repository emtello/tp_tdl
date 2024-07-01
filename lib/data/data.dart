import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;
  final IconData icon;
  double totalAmount;

  Category({
    required this.name,
    required this.color,
    required this.icon,
    this.totalAmount = 0.0,
  });
}

class Transaction {
  final String name;
  final double totalAmount;
  final DateTime date;
  final Category category;

  Transaction({
    required this.name,
    required this.totalAmount,
    required this.date,
    required this.category,
  });
}

List<Category> categoriesList = [
  Category(name: 'Food', color: Colors.blue, icon: Icons.fastfood),
  Category(name: 'Personal', color: Colors.deepOrange, icon: Icons.person),
  Category(name: 'Clothing', color: Colors.purple, icon: Icons.shopping_bag),
  Category(name: 'Transport', color: Colors.yellow, icon: Icons.train),
];
