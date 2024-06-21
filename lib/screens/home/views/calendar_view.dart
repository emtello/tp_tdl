import 'package:expenses_app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/screens/edit_transactions.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late Map<DateTime, List> _events;
  late List _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedEvents = [];
  }

  @override
  Widget build(BuildContext context) {
    final expenseModel = Provider.of<ExpenseModel>(context);

    _events = _groupEventsByDate(expenseModel.transactionsList);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Calendar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 15.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 3.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = DateTime(
                      selectedDay.year,
                      selectedDay.month,
                      selectedDay.day,
                    );
                    _focusedDay = focusedDay;

                    DateTime selectedDayWithoutTimezone = DateTime(
                      _selectedDay.year,
                      _selectedDay.month,
                      _selectedDay.day,
                    );

                    _selectedEvents = _events[selectedDayWithoutTimezone] ?? [];
                  });
                },
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                  CalendarFormat.week: 'Week',
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                rowHeight: 50.0,
                calendarStyle: CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 54, 72, 142),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 54, 72, 142),
                    shape: BoxShape.circle,
                  ),
                ),
                eventLoader: (day) {
                  DateTime dayWithoutTimezone = DateTime(
                    day.year,
                    day.month,
                    day.day,
                  );
                  return _events[dayWithoutTimezone] ?? [];
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              _selectedEvents.isEmpty
                  ? 'No transactions on ${_selectedDay.toString().substring(0, 10).split('-').join('/')}'
                  : 'Transactions on ${_selectedDay.toString().substring(0, 10)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _selectedEvents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(_selectedEvents[index].category.icon,
                        color: _selectedEvents[index].category.color),
                    title: Text(_selectedEvents[index].name),
                    subtitle: Text('${_selectedEvents[index].category.name}'),
                    trailing: Text(
                        '\$${_selectedEvents[index].totalAmount.toStringAsFixed(2)}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              EditTransactionScreen(
                            transaction: _selectedEvents[index],
                            index: index,
                          ),
                        ),
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

  Map<DateTime, List> _groupEventsByDate(List<Transaction> transactions) {
    Map<DateTime, List> data = {};
    for (var transaction in transactions) {
      DateTime date = DateTime(
        transaction.date.year,
        transaction.date.month,
        transaction.date.day,
      );

      if (data[date] == null) {
        data[date] = [];
      }
      data[date]!.add(transaction);
    }
    return data;
  }
}
