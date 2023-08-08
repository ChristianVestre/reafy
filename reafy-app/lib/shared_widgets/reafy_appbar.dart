import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/auth_provider.dart';

class ReafyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReafyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      print(authProvider.user.company);
      return SafeArea(
          child: AppBar(
        automaticallyImplyLeading: false,
        bottomOpacity: 0,
        flexibleSpace:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: const Text("reafy",
                      style: TextStyle(
                          color: Color(0xFFD499B9),
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                          fontFamily: 'PlayfairDisplay')))),
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 2),
                  child: const Text("ScaleupXQ",
                      style: TextStyle(
                          fontSize: 20, fontFamily: 'PlayfairDisplay')))),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                      onTap: () => authProvider.logout(),
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(authProvider.user.picture!),
                            ),
                          )))))
          //child: Image(
          //image: NetworkImage(authProvider.user.picture!)))))
        ]),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ));
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
