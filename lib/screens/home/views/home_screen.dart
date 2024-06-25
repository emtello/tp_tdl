import 'package:expenses_app/screens/add/add.dart';
import 'package:expenses_app/screens/home/views/graphs_screen.dart';
import 'package:expenses_app/screens/home/views/main_screen.dart';
import 'package:expenses_app/screens/home/views/calendar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var widgetList = [
    const MainScreen(),
    const CalendarScreen(),
    const GraphsScreen(),
    const Placeholder()
  ];

  int barIndex = 0;
  Color selectedItemColor = Colors.blueAccent;
  Color unselectedItemColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              setState(() {
                barIndex = value;
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blueAccent,
            backgroundColor: Colors.white,
            elevation: 3,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home,
                      color: barIndex == 0
                          ? selectedItemColor
                          : unselectedItemColor),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.calendar,
                      color: barIndex == 1
                          ? selectedItemColor
                          : unselectedItemColor),
                  label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chart_bar_square,
                      color: barIndex == 2
                          ? selectedItemColor
                          : unselectedItemColor),
                  label: 'Charts'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.gear,
                      color: barIndex == 3
                          ? selectedItemColor
                          : unselectedItemColor),
                  label: 'Settings')
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AddTransaction(),
                ));
          },
          shape: const CircleBorder(),
          child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ],
                    transform: const GradientRotation(math.pi / 2),
                  )),
              child: const Icon(CupertinoIcons.add)),
        ),
        body: widgetList[barIndex]);
  }
}
