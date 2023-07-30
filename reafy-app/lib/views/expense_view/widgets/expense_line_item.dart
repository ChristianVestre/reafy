import 'package:flutter/cupertino.dart';

class ExpenseLineItem extends StatelessWidget {
  const ExpenseLineItem({Key? key, required this.item}) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: CupertinoListTile(
          title: Text(item),
          trailing: const Icon(
            CupertinoIcons.chevron_right,
          ),
        ));
  }
}
