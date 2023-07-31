import 'package:flutter/material.dart';

class ReafyNavBar extends StatelessWidget implements PreferredSizeWidget {
  const ReafyNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AppBar(
      automaticallyImplyLeading: false,
      bottomOpacity: 0,
      flexibleSpace: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("reafy",
                style: TextStyle(
                    color: Color(0xFFD499B9),
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                    fontFamily: 'PlayfairDisplay')),
            Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text("ScaleupXQ",
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'PlayfairDisplay'))),
            CircleAvatar()
          ]),
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
