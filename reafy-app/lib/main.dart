import 'package:flutter/cupertino.dart';
import 'package:reafy/views/verify_expense.dart';
import 'views/expense_object_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(primaryColor: Color(0xFFD499B9)),
      home: VerifyExpenseView(),
    );
  }
}
