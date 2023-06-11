import 'package:flutter/cupertino.dart';

final items = ["Test 1", "test 2", "test 3"];

class ExpenseObjectList extends StatelessWidget {
  const ExpenseObjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: ((context, index) => Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: CupertinoListTile(
              title: Text(items[index]),
              trailing: const Icon(
                CupertinoIcons.chevron_right,
              ),
            ))));
  }
}
