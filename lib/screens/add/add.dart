import 'package:flutter/material.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New Expense',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              Text('What did you spend today?',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400)),
              TextFormField(),
              SizedBox(height: 20),
              TextFormField(),
              SizedBox(height: 40),
              DropdownButton(
                  iconSize: 30,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(child: Text('test'), value: 'test1'),
                    DropdownMenuItem(child: Text('test2'), value: 'test2'),
                    DropdownMenuItem(child: Text('test3'), value: 'test3')
                  ],
                  onChanged: (value) {}),
            ],
          ),
        ));
  }
}
