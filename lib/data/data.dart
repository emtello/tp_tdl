// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
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
