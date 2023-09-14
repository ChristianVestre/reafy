import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reafy/provider/auth_provider.dart';
import 'package:reafy/views/expense_view/expense_view.dart';
import 'package:reafy/views/login/login_view.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).initAuth();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return authProvider.isLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : authProvider.isLoggedIn
              ? const ExpenseView()
              : const LoginView();
    });
  }
}
