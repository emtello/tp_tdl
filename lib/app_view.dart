import 'package:flutter/material.dart';

import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              background: Colors.grey.shade100,
              onBackground: Colors.black,
              primary: const Color(0xFF3C41A4),
              secondary: const Color(0xFF14156F),
              tertiary: const Color(0xFFFF8D6C),
              outline: Colors.grey.shade400)),
      home: const HomeScreen(),
    );
  }
}
