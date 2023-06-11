import 'package:flutter/cupertino.dart';
import '../components/new_expense_object_intent.dart';
import '../components/new_expense_object_participant_input.dart';
import '../components/new_expense_object_participant_list.dart';
import '../components/reafy_nav_bar.dart';

enum NewExpenseObjectStateEnum { list, input, intent }

enum NewExpenseObjectTypeEnum {
  fradragsberettigetRepresentasjon,
  ikkeFradragsberettigetRepresentasjon,
  velferd
}

class Participant {
  String name;
  String? company;

  Participant({required this.name, this.company});
}

class NewExpenseObjectData {
  ValueNotifier<List<Participant>> participants;
  String? intent;
  ValueNotifier<NewExpenseObjectTypeEnum> type;

  NewExpenseObjectData(
      {required this.participants, required this.intent, required this.type});
}

class NewExpenseObjectView extends StatefulWidget {
  const NewExpenseObjectView({Key? key}) : super(key: key);

  @override
  NewExpenseObjectViewState createState() => NewExpenseObjectViewState();
}

class NewExpenseObjectViewState extends State<NewExpenseObjectView> {
  final widgetState = ValueNotifier(NewExpenseObjectStateEnum.intent);

  NewExpenseObjectData data = NewExpenseObjectData(
      participants: ValueNotifier(
          [Participant(name: "Christian Vestre", company: "ScaleupXQ")]),
      type: ValueNotifier(
          NewExpenseObjectTypeEnum.ikkeFradragsberettigetRepresentasjon),
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
                        case NewExpenseObjectStateEnum.list:
                          {
                            return NewExpenseObjectParticipantList(
                                data: data, state: widgetState);
                          }

                        case NewExpenseObjectStateEnum.input:
                          {
                            return NewExpenseObjectParticipantInput(
                                data: data, state: widgetState);
                          }
                        case NewExpenseObjectStateEnum.intent:
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
