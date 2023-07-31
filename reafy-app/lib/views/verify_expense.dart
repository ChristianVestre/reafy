import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafy/views/expense_view/expense_view.dart';
import '../shared_widgets/expense_items.dart';
import '../shared_widgets/reafy_nav_bar.dart';

class VerifyExpenseView extends StatelessWidget {
  const VerifyExpenseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReafyNavBar(),
      body: Center(
          child: Column(children: [
        const Text("New expense",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Column(children: [
            const Text("Mesh Youngstorget",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            const Text("31.05.23"),
            const ExpenseItems(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                    padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
                    borderRadius: const BorderRadius.all(Radius.circular(1)),
                    child: const Text("Decline"),
                    onPressed: () => {}),
                const SizedBox(width: 50),
                CupertinoButton.filled(
                    padding: const EdgeInsets.fromLTRB(32, 4, 32, 4),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: const Text("Accept"),
                    onPressed: () => {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const ExpenseView(),
                            ),
                          )
                        })
              ],
            )
          ]),
        )
      ])),
    );
  }
}
