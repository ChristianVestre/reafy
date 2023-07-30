import 'package:flutter/cupertino.dart';

final items = ["Beer", "Beer & Snack", "Beer"];

class ExpenseItems extends StatelessWidget {
  const ExpenseItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: ((context, index) => CupertinoListTile(
              title: Text(items[index]),
            )));
  }
}
