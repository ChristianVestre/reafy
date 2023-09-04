import 'package:flutter/material.dart';

class ExpenseDetailRow extends StatelessWidget {
  const ExpenseDetailRow(
      {Key? key, required this.leadingText, required this.trailingText})
      : super(key: key);

  final String leadingText;
  final String trailingText;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leadingText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              trailingText,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ));
  }
}
