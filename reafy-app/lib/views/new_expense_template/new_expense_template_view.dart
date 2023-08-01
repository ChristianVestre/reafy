import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/provider/state_provider.dart';
import '../../shared_widgets/new_expense_template_intent.dart';
import '../../shared_widgets/new_expense_template_participant_input.dart';
import 'widgets/new_expense_template_participant_list.dart';
import '../../shared_widgets/reafy_appbar.dart';
import '../../models/enums.dart';
import '../../models/expense_template.dart';
import '../../models/participant.dart';

class NewExpenseTemplateView extends StatefulWidget {
  const NewExpenseTemplateView({
    Key? key,
  }) : super(key: key);

  @override
  State<NewExpenseTemplateView> createState() => _NewExpenseTemplateViewState();
}

class _NewExpenseTemplateViewState extends State<NewExpenseTemplateView> {
  @override
  bool search = false;

  @override
  void initState() {
    super.initState();
    final expenseTemplateProvider =
        Provider.of<ExpenseTemplateProvider>(context, listen: false);
    expenseTemplateProvider.getParticipantList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ReafyAppBar(),
        body: Consumer<ExpenseTemplateProvider>(
            builder: (context, expenseTemplateProvider, child) {
          return expenseTemplateProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      child: (() {
                        switch (context
                            .watch<StateProvider>()
                            .newExepenseTemplateState
                            .step) {
                          case NewExpenseTemplateStateEnum.list:
                            {
                              return const NewExpenseTemplateParticipantList();
                            }
                          default:
                            {
                              return const NewExpenseTemplateParticipantList();
                            }
/*
                    case NewExpenseTemplateStateEnum.input:
                      {
                        return NewExpenseObjectParticipantInput();
                      }
                    case NewExpenseTemplateStateEnum.intent:
                      {
                        return NewExpenseObjectIntent();
                      }
                    default:
                      {
                        return NewExpenseObjectIntent();
                      }*/
                        }
                      })()));
        }));
  }
}
