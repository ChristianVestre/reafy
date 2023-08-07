import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/data_provider.dart';
import 'package:reafy/provider/state_provider.dart';
import 'package:reafy/views/expense_view/expense_view.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => StateProvider()),
    ChangeNotifierProxyProvider(
      create: (BuildContext context) => DataProvider(),
      update: (context, value, previous) => DataProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reafy',
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primaryColor: const Color(0xFFD499B9),
          primaryIconTheme: const IconThemeData(color: Color(0xFFD499B9)),
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: Color(0xFFD499B9)),
          unselectedWidgetColor: const Color(0xFFBDBDBD),
          iconTheme: const IconThemeData(color: Color(0xFFD499B9)),
          textTheme: const TextTheme(
              titleLarge: TextStyle(
                  fontSize: 32,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD499B9)),
              titleMedium: TextStyle(
                  fontSize: 24,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFD499B9)),
              titleSmall: TextStyle(
                  fontSize: 16,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD499B9)),
              headlineLarge: TextStyle(fontSize: 24, color: Colors.black),
              headlineMedium: TextStyle(fontSize: 16, color: Colors.black),
              headlineSmall: TextStyle(fontSize: 12),
              bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              bodyMedium: TextStyle(fontSize: 12))),
      home: const ExpenseView(),
    );
  }
}
