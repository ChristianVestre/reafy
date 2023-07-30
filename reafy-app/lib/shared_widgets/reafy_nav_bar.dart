import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReafyNavBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const ReafyNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      leading: Padding(
        padding: EdgeInsets.only(top: 0),
        child: Text("reafy",
            style: TextStyle(
                color: Color(0xFFD499B9),
                fontWeight: FontWeight.w900,
                fontSize: 32,
                fontFamily: 'PlayfairDisplay')),
      ),
      middle: Padding(
          padding: EdgeInsets.only(top: 2),
          child: Text("ScaleupXQ",
              style: TextStyle(fontSize: 20, fontFamily: 'PlayfairDisplay'))),
      trailing: CircleAvatar(),
      backgroundColor: Colors.transparent,
      border: Border(bottom: BorderSide.none),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
