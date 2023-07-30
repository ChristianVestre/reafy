import 'package:flutter/cupertino.dart';
import 'package:reafy/shared_widgets/buttons/reafy_text_button.dart';
import 'package:reafy/shared_widgets/reafy_nav_bar.dart';
import 'package:reafy/views/expense_view/widgets/expense_detail.dart';
import 'package:reafy/views/new_expense_template_view.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const ReafyNavBar(),
        child: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
              const ExpenseDetail(),
              ReafyTextButton(
                  onPressed: () => {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const NewExpenseObjectView(),
                          ),
                        )
                      },
                  text: "New expense template")
            ]))));
  }
}
