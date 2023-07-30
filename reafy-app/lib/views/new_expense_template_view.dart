import 'package:flutter/cupertino.dart';
import '../shared_widgets/new_expense_template_intent.dart';
import '../shared_widgets/new_expense_template_participant_input.dart';
import '../shared_widgets/new_expense_template_participant_list.dart';
import '../shared_widgets/reafy_nav_bar.dart';
import '../models/enums.dart';
import '../models/expense_template.dart';
import '../models/participant.dart';

class NewExpenseObjectView extends StatefulWidget {
  const NewExpenseObjectView({Key? key}) : super(key: key);

  @override
  NewExpenseObjectViewState createState() => NewExpenseObjectViewState();
}

class NewExpenseObjectViewState extends State<NewExpenseObjectView> {
  final widgetState = ValueNotifier(NewExpenseTemplateStateEnum.intent);

  NewExpenseTemplateData data = NewExpenseTemplateData(
      participants: ValueNotifier(
          [Participant(name: "Christian Vestre", company: "ScaleupXQ")]),
      type: ValueNotifier(
          NewExpenseTemplateTypeEnum.ikkeFradragsberettigetRepresentasjon),
      intent: "Møteservering");

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const ReafyNavBar(),
      child: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: widgetState,
              builder: (context, value, _) {
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: (() {
                      switch (value) {
                        case NewExpenseTemplateStateEnum.list:
                          {
                            return NewExpenseObjectParticipantList(
                                data: data, state: widgetState);
                          }

                        case NewExpenseTemplateStateEnum.input:
                          {
                            return NewExpenseObjectParticipantInput(
                                data: data, state: widgetState);
                          }
                        case NewExpenseTemplateStateEnum.intent:
                          {
                            return NewExpenseObjectIntent(
                                data: data, state: widgetState);
                          }
                        default:
                          {
                            return NewExpenseObjectIntent(
                                data: data, state: widgetState);
                          }
                      }
                    })());
              })),
    );
  }
}
