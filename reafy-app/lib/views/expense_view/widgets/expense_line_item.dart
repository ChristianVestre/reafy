import 'package:flutter/material.dart';

class ExpenseLineItem extends StatelessWidget {
  const ExpenseLineItem({Key? key, required this.item}) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      leading: Text(item),
      trailing: Text("23"),
    );
  }
}
