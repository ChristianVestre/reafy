import 'package:flutter/material.dart';
import 'package:reafy/views/expense_view/widgets/expense_line_item.dart';

final items = ["Test 1", "test 2", "test 3"];

class ExpenseDetail extends StatelessWidget {
  const ExpenseDetail({super.key, this.data});

  final data;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const SizedBox(height: 60),
      const Text(
        "Select Expense Object for",
        style: TextStyle(fontSize: 24),
      ),
      const Text("Mesh Youngstorget 31.05.23"),
      const SizedBox(height: 20),
      ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: ((context, index) =>
              ExpenseLineItem(item: items[index])))
    ]));
  }
}
