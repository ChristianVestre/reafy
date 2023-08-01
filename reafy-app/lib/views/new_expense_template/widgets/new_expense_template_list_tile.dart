import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/expense_template.dart';
import '../../../models/participant.dart';

class NewExpenseObjectListTile extends StatelessWidget {
  const NewExpenseObjectListTile(
      {Key? key,
      required this.participant,
      this.deletable,
      required this.data,
      required this.index})
      : super(key: key);

  final NewExpenseTemplateData data;
  final Participant participant;
  final int index;
  final bool? deletable;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        height: 50,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Text(
              participant.participantName!,
            ),
            const SizedBox(width: 20),
            Text(
              (() {
                if (participant.companyName != null) {
                  return participant.companyName!;
                }
                return " ";
              })(),
              style: const TextStyle(color: Colors.black54),
            )
          ]),
          Visibility(
              visible: deletable == true,
              child: CupertinoButton(
                  child: const Icon(CupertinoIcons.xmark, size: 20),
                  onPressed: () => {
                        /*
                        data.participants.value.remove(participant),
                        data.participants.value =
                            List.from(data.participants.value) */
                      }))
        ]));
  }
}
