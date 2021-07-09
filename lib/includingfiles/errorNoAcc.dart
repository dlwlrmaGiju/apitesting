import 'package:flutter/material.dart';

class LoginError extends StatefulWidget {
  const LoginError({Key? key}) : super(key: key);

  @override
  _LoginErrorState createState() => _LoginErrorState();
}

class _LoginErrorState extends State<LoginError> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Text("why is this shit black"),
    );
  }
}
