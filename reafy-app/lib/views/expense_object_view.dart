import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafy/views/new_expense_object_view.dart';

import '../components/expense_object_list.dart';

class ExpenseObjectView extends StatelessWidget {
  const ExpenseObjectView({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          leading: Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text("reafy",
                style: TextStyle(
                    color: Color(0xFFD499B9),
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                    fontFamily: 'PlayfairDisplay')),
          ),
          middle: Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text("ScaleupXQ", style: TextStyle(fontSize: 20))),
          trailing: CircleAvatar(),
          backgroundColor: Colors.transparent,
          border: Border(bottom: BorderSide.none),
        ),
        child: SafeArea(
            child: Center(
                child: Column(children: [
          const SizedBox(height: 60),
          const Text(
            "Select Expense Object for",
            style: TextStyle(fontSize: 24),
          ),
          const Text("Mesh Youngstorget 31.05.23"),
          const SizedBox(height: 20),
          const Expanded(child: ExpenseObjectList()),
          CupertinoButton(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.plus),
                  SizedBox(width: 10),
                  Text(
                    "New expense object",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              onPressed: () => {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const NewExpenseObjectView(),
                      ),
                    )
                  })
        ]))));
  }
}
