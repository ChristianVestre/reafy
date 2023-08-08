import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/auth_provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottomOpacity: 0,
            toolbarOpacity: 0,
            shadowColor: Colors.transparent,
            flexibleSpace: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: const Text(
                  "reafy",
                  style: TextStyle(
                      color: Color(0xFFD499B9),
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      fontFamily: 'PlayfairDisplay'),
                ),
              ),
            ),
            toolbarHeight: 50,
          ),
          body: Center(
              child: Column(children: [
            const SizedBox(
              height: 64,
            ),
            Text(
              "Login",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
                onTap: () =>
                    {Provider.of<AuthProvider>(context, listen: false).login()},
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color(0xFFBDBDBD)),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/google-icon.png',
                          height: 30,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Login with google",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    )))
          ])));
    });
  }
}
