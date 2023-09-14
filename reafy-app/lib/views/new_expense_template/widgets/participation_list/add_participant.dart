import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/enums.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/reafy_nav_footer.dart';
import 'package:reafy/shared_widgets/reafy_text_field.dart';
import 'package:reafy/theme/colors.dart';
import 'package:reafy/models/participants.dart';

class AddParticipant extends StatefulWidget {
  const AddParticipant({Key? key}) : super(key: key);

  @override
  _AddParticipantState createState() => _AddParticipantState();
}

class _AddParticipantState extends State<AddParticipant> {
  final nameController = TextEditingController();
  final relationsController = TextEditingController();
  final newCompanyController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    relationsController.dispose();
    newCompanyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: const EdgeInsets.all(16),
              child: Column(children: [
                Text(
                  "Add participant",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 32,
                ),
                ReafyTextField(
                  controller: nameController,
                  onChanged: (value) => {
                    expenseTemplateProvider.newParticipant.participantName =
                        value,
                  },
                  hintText: "Name",
                ),
                const SizedBox(
                  height: 32,
                ),
                ReafyTextField(
                  controller: relationsController,
                  onChanged: (value) =>
                      {expenseTemplateProvider.newParticipant.relation = value},
                  hintText: "Relation",
                ),
                const SizedBox(
                  height: 32,
                ),
                InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Theme.of(context).lightGray))),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(5),
                            value: expenseTemplateProvider
                                .newParticipant.companyName,
                            elevation: 2,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? value) {
                              expenseTemplateProvider
                                  .updateParticipantCompany(value!);
                            },
                            hint: const Text("Select company"),
                            items: expenseTemplateProvider.expenseTemplateState
                                .tempData!.participants?.participantCompanies!
                                .map<DropdownMenuItem<String>>(
                                    (String companyName) {
                              return DropdownMenuItem<String>(
                                value: companyName,
                                child: Text(companyName),
                              );
                            }).followedBy([
                              const DropdownMenuItem<String>(
                                value: "New company",
                                child: Text("New company"),
                              )
                            ]).toList()))),
                if (expenseTemplateProvider.newParticipant.companyName ==
                    "New company")
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Please write the name of the new company",
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ReafyTextField(
                        controller: newCompanyController,
                        onChanged: (String value) {
                          expenseTemplateProvider
                              .newParticipant.newCompanyName = value;
                        },
                        hintText: "Company name",
                      )
                    ],
                  ),
              ])),
          ReafyNavFooter(
            backText: "Back",
            forwardText: "Save",
            backOnPressed: () => {
              expenseTemplateProvider
                  .updateStateStep(NewExpenseTemplateStateEnum.list)
            },
            forwardOnPressed: () => {
              if (expenseTemplateProvider.newParticipant.participantName ==
                      null ||
                  expenseTemplateProvider.newParticipant.relation == null ||
                  (expenseTemplateProvider.newParticipant.companyName ==
                          "New company" &&
                      expenseTemplateProvider.newParticipant.newCompanyName ==
                          null) ||
                  expenseTemplateProvider.newParticipant.companyName == null)
                {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Center(
                    child: Text('Please fill in all fields'),
                  )))
                }
              else
                {
                  expenseTemplateProvider.submitParticipant(),
                  expenseTemplateProvider
                      .updateStateStep(NewExpenseTemplateStateEnum.list)
                }
            },
          )
        ],
      );
    });
  }
}
