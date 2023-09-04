import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_provider.dart';

class ExpenseParticipants extends StatelessWidget {
  const ExpenseParticipants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
      return Container(
        margin: const EdgeInsets.only(top: 32),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Participants:"),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: expenseProvider.selectedExpenseTemplate
                        .participants?.participants?.length,
                    itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          '${expenseProvider.selectedExpenseTemplate.participants!.participants![index].participantName!} - ${expenseProvider.selectedExpenseTemplate.participants!.participants![index].companyName!}',
                          textAlign: TextAlign.end,
                        ))),
              )
            ]),
      );
    });
  }
}
