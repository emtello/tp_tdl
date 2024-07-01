import 'package:expenses_app/app.dart';
import 'package:expenses_app/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseModel(),
      child: const MyApp(),
    ),
  );
}
