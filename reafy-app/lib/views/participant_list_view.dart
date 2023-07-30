import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:reafy/components/new_expense_object_participant_list.dart';
import 'package:reafy/provider/data_provider.dart';

import '../components/reafy_nav_bar.dart';

class ParticipantListView extends StatefulWidget {
  const ParticipantListView({Key? key}) : super(key: key);

  @override
  State<ParticipantListView> createState() => _ParticipantListViewState();
}

class _ParticipantListViewState extends State<ParticipantListView> {
  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.getParticipantList();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    print(dataProvider.responseData.data?.first.companyName);
    return const CupertinoPageScaffold(
        navigationBar: ReafyNavBar(), child: SafeArea(child: Text("Test")));
  }
}
