import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/shared_widgets/reafy_text_field.dart';
import 'package:reafy/theme/colors.dart';

class AddParticipant extends StatelessWidget {
  const AddParticipant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return Container(
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
              controller: expenseTemplateProvider.newParticipant.nameController,
              hintText: "Name",
            ),
            const SizedBox(
              height: 32,
            ),
            InputDecorator(
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.5, color: Theme.of(context).lightGray))),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(5),
                        value:
                            expenseTemplateProvider.newParticipant.companyName,
                        elevation: 2,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? value) {
                          expenseTemplateProvider
                              .updateParticipantCompany(value!);
                        },
                        hint: const Text("Select company"),
                        items: expenseTemplateProvider.expenseTemplateState!
                            .tempData!.participants!.participantCompanies!
                            .map<DropdownMenuItem<String>>(
                                (String companyName) {
                          return DropdownMenuItem<String>(
                            value: companyName,
                            child: Text(companyName),
                          );
                        }).toList()))),
            const SizedBox(
              height: 32,
            ),
            ReafyTextField(
              controller:
                  expenseTemplateProvider.newParticipant.relationController,
              hintText: "Relation",
            )
          ]));
    });
  }
}
