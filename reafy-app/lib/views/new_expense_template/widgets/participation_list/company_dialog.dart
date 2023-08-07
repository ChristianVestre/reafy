import 'package:flutter/material.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/theme/colors.dart';

final listOfCompanies = ["ScaleupXQ", "Tyve", "Code11"];

companyDialog(BuildContext context,
        ExpenseTemplateProvider expenseTemplateProvider) =>
    {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Companies',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: listOfCompanies.length,
                          itemBuilder: ((context, index) => GestureDetector(
                              onTap: () => {
                                    expenseTemplateProvider
                                        .updateSearchResultWithCompany(
                                            listOfCompanies[index]),
                                    Navigator.pop(context)
                                  },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).borderColor),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text(listOfCompanies[index],
                                        style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .fontSize,
                                            fontWeight: FontWeight.w300))),
                              )))),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ))
    };
