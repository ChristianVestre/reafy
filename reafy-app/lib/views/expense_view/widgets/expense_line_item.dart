import 'package:flutter/material.dart';
import 'package:reafy/models/expense.dart';

class ExpenseLineItem extends StatelessWidget {
  const ExpenseLineItem({Key? key, required this.item}) : super(key: key);

  final LineItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.name!,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
              '${item.numberPurchased!.toString()} x ${(item.costPerItem! / 10).round().toString()} kr',
              style: Theme.of(context).textTheme.bodyLarge)
        ],
      ),
    );
  }
}
