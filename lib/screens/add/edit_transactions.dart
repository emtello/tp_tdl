import 'package:expenses_app/data/data.dart';
import 'package:expenses_app/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTransactionScreen extends StatefulWidget {
  final Transaction transaction;
  final int index;

  const EditTransactionScreen({
    super.key,
    required this.transaction,
    required this.index,
  });

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _amount;
  late String _category;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _name = widget.transaction.name;
    _amount = widget.transaction.totalAmount;
    _category = widget.transaction.category.name;
    _date = widget.transaction.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Transaction'),
                    content: const Text(
                        'Are you sure you want to delete this transaction?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<ExpenseModel>(context, listen: false)
                              .removeTransaction(widget.index);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _amount.toString(),
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: Provider.of<ExpenseModel>(context, listen: false)
                    .categories
                    .map((Category category) {
                  return DropdownMenuItem<String>(
                    value: category.name,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  _category = value!;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${DateTime.now().year == _date.year && DateTime.now().month == _date.month && DateTime.now().day == _date.day ? "Today" : "${_date.year}/${_date.month}/${_date.day}"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != _date) {
                        setState(() {
                          _date = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final updatedTransaction = Transaction(
                      name: _name,
                      totalAmount: _amount,
                      date: _date,
                      category: Provider.of<ExpenseModel>(context,
                              listen: false)
                          .categories
                          .firstWhere((category) => category.name == _category),
                    );
                    Provider.of<ExpenseModel>(context, listen: false)
                        .updateTransaction(widget.index, updatedTransaction);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
