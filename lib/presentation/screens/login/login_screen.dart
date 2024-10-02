import 'package:flutter/material.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/login/providers/login_provider.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/login/widgets/login_card.dart';
import 'package:masterclass_rick_and_morty_app/presentation/styles/colors.dart';

final mainTextColor = lightColorScheme.onPrimary;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [LoginCard(loginProvider: loginProvider)],
      ),
    ));
  }
}
