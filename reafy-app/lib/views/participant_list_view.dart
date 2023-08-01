import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/data_provider.dart';

import '../shared_widgets/reafy_appbar.dart';

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
    return const Scaffold(
        appBar: ReafyAppBar(), body: SafeArea(child: Text("Test")));
  }
}
