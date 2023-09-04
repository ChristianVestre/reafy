import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/views/new_expense_template/widgets/intent/new_expense_template_intent.dart';
import 'package:reafy/views/new_expense_template/widgets/overview/new_expense_template_overview.dart';
import 'package:reafy/views/new_expense_template/widgets/participation_list/add_participant.dart';
import 'package:reafy/views/new_expense_template/widgets/participation_list/new_expense_template_participant_list.dart';
import 'package:reafy/views/new_expense_template/widgets/type/new_expense_template_type.dart';
import '../../shared_widgets/reafy_appbar.dart';
import '../../models/enums.dart';

class NewExpenseTemplateView extends StatefulWidget {
  const NewExpenseTemplateView({
    Key? key,
  }) : super(key: key);

  @override
  State<NewExpenseTemplateView> createState() => _NewExpenseTemplateViewState();
}

class _NewExpenseTemplateViewState extends State<NewExpenseTemplateView> {
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
                            .watch<ExpenseTemplateProvider>()
                            .expenseTemplateState
                            .step) {
                          case NewExpenseTemplateStateEnum.list:
                            {
                              return const NewExpenseTemplateParticipantList();
                            }
                          case NewExpenseTemplateStateEnum.intent:
                            {
                              return const NewExpenseTemplateIntent();
                            }
                          case NewExpenseTemplateStateEnum.type:
                            {
                              return const NewExpenseTemplateType();
                            }
                          case NewExpenseTemplateStateEnum.overview:
                            {
                              return NewExpenseTemplateOverview();
                            }
                          case NewExpenseTemplateStateEnum.participant:
                            {
                              return const AddParticipant();
                            }
                          default:
                            {
                              return const NewExpenseTemplateParticipantList();
                            }
                        }
                      })()));
        }));
  }
}
