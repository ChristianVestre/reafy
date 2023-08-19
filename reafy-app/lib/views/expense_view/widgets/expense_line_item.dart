import 'package:flutter/material.dart';

class ExpenseLineItem extends StatelessWidget {
  const ExpenseLineItem({Key? key, required this.item}) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          item,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text("23", style: Theme.of(context).textTheme.bodyLarge)
      ]),
    );
  }
}
