import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/models/participant.dart';
import 'package:reafy/provider/expense_template_provider.dart';
import 'package:reafy/theme/colors.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile(
      {Key? key, required this.participant, this.selectable = true})
      : super(key: key);

  final Participant participant;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseTemplateProvider>(
        builder: (context, expenseTemplateProvider, child) {
      return GestureDetector(
          onTap: () => {
                selectable
                    ? expenseTemplateProvider
                        .updateSelectedParticipants(participant)
                    : null
              },
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              decoration: BoxDecoration(
                  border: participant.selected!
                      ? Border.all(color: Theme.of(context).primaryColor)
                      : Border.all(color: Theme.of(context).borderColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(children: [
                Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                        checkColor: Theme.of(context).primaryColor,
                        side: MaterialStateBorderSide.resolveWith(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.5);
                          }
                          return BorderSide(
                              color: Theme.of(context).borderColor,
                              width:
                                  1.5); // Defer to default value on the theme or widget.
                        }),
                        activeColor: Colors.white,
                        value: participant.selected,
                        onChanged: (check) => {
                              selectable
                                  ? expenseTemplateProvider
                                      .updateSelectedParticipants(participant)
                                  : null
                            })),
                Text(
                  participant.participantName.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 8),
                Text(
                  participant.companyName.toString(),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w300),
                )
              ])));
    });
  }
}
