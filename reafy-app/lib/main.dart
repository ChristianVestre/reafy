import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/data_provider.dart';
import 'package:reafy/views/expense_view/expense_view.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DataProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reafy',
      theme: ThemeData(
          primaryColor: const Color(0xFFD499B9),
          textTheme: const TextTheme(displayLarge: TextStyle(fontSize: 10))),
      home: const ExpenseView(),
    );
  }
}
